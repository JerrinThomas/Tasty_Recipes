//
//  AccountViewController.swift
//  TastyRecipes
//
//  Created by user204823 on 3/30/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        navigationItem.title = "Account"
        
        if let user = Auth.auth().currentUser {
            emailLabel.text = user.email
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.setRounded()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

                profileImage.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
        }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    func isValidEmailAddress(emailAddressString: String, passwordString: String) {
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                showErrorDialog(title: "Invalid Email", message: "Please enter valid email!!")
                return
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return
        }
                
        if let user = Auth.auth().currentUser {
            user.reauthenticate(with: EmailAuthProvider.credential(withEmail: user.email ?? "", password: passwordString)) { result,error  in
              if let error = error {
                self.showErrorDialog(title: "Incorrect Password", message: "Please enter valid password!!")
                print("Password error: \(error)")
              } else {
                user.updateEmail(to: emailAddressString) { (error) in
                    if let error = error{
                        print("Email error: \(error)")
                    }
                    else{
                        print("success")
                        self.showErrorDialog(title: "Success", message: "Email is updated!!")
                        self.usernameLabel.text = user.email
                    }
                }
              }
            }
        }
        return
    }
    
    func showErrorDialog(title:String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
            })
        
    }
    
    func showUpdateEmailDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputOnePlaceholder:String? = nil,
                         inputTwoPlaceholder:String? = nil,
                         inputOneKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         inputTwoKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?, _ text:String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputOnePlaceholder
            textField.keyboardType = inputOneKeyboardType
        }
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputTwoPlaceholder
            textField.keyboardType = inputTwoKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textFieldOne =  alert.textFields?[0], let textFieldTwo = alert.textFields?[1] else {
                actionHandler?(nil,nil)
                return
            }
            actionHandler?(textFieldOne.text,textFieldTwo.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
            })
        
    }
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBAction func profileImagePickerButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func editEmailButton(_ sender: Any) {
        showUpdateEmailDialog(title: "Update Email", subtitle: "Please enter new email and old password below.", actionTitle: "Update", cancelTitle: "Cancle", inputOnePlaceholder: "New Email", inputTwoPlaceholder: "Old Password", inputOneKeyboardType: .emailAddress, inputTwoKeyboardType: .default, cancelHandler: nil, actionHandler: { (email,password) in
            self.isValidEmailAddress(emailAddressString: email ?? "iaminvalid",passwordString: password ?? "iamincorrect")
        })
        
        	
    }
    
    @IBAction func touchLogout(_ sender: Any) {
        try? Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false, completion: nil)
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    
}

extension UIImageView {
    func setRounded() {
        layer.cornerRadius = bounds.height/2
        layer.masksToBounds = true
    }
}

