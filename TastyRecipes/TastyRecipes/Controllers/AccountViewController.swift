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
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//
//                profileImage.image = pickedImage
//            }
//
//            dismiss(animated: true, completion: nil)
//        }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            dismiss(animated: true, completion: nil)
//    }
    
//    func isValidEmailAddress(emailAddressString: String) {
//        
//        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
//        
//        do {
//            let regex = try NSRegularExpression(pattern: emailRegEx)
//            let nsString = emailAddressString as NSString
//            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
//            
//            if results.count == 0
//            {
//                let alert = UIAlertController(title: "Invalid Email", message: "Please enter valid email.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                return
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            return
//        }
//                
//        if let user = Auth.auth().currentUser {
//            var credential: AuthCredential = EmailAuthProvider.credential(withEmail: user.email, password: user.pass)
//            user.reauthenticate(with: credential) { result,error  in
//              if let error = error {
//                print(error)
//              } else {
//                // User re-authenticated.
//              }
//            }
//        }
//        return
//    }
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBAction func profileImagePickerButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func editEmailButton(_ sender: Any) {
        showInputDialog(title: "Update Email",
                        subtitle: "Please enter new email below.",
                        actionTitle: "Update",
                        cancelTitle: "Cancel",
                        inputPlaceholder: "New email",
                        inputKeyboardType: .emailAddress, actionHandler:
                                { (input:String?) in
//                                    self.isValidEmailAddress(emailAddressString: input ?? "iaminvalid")
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

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
