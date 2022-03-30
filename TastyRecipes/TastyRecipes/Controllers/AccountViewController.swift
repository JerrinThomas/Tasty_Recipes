//
//  AccountViewController.swift
//  TastyRecipes
//
//  Created by user204823 on 3/30/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    @IBAction func touchLogout(_ sender: Any) {
        try? Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false, completion: nil)
    }
    
}
