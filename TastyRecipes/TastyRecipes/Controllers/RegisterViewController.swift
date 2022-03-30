//
//  RegisterViewController.swift
//  TastyRecipes
//
//  Created by user204824 on 3/30/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
  
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButton(_ sender: Any) {
        
        guard let username = userName.text,
              let email = email.text,
              let password = password.text,
              let confirmPassword = confirmPassword.text,
              username != "",
              email != "",
              password != "" else {
            let alert = UIAlertController(title: "Incorrect Email or Password", message: "Please fill field properly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return }
        
        guard password == confirmPassword else {
            let alert = UIAlertController(title: "Incorrect Password & Confirm Password", message: "Password & confirm password should same", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password){ [weak self]authResult, error in
            guard let strongSelf = self else { return }
            
            if error == nil {
                strongSelf.showMainscreen()
            } else {
                let alert = UIAlertController(title: "Error Registering", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func showMainscreen() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
}
