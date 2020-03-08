//
//  SignUpPage.swift
//  LOVECHAT
//
//  Created by kittawat phuangsombat on 2020/3/1.
//  Copyright © 2020 kittawat phuangsombat. All rights reserved.
//


import UIKit
import Firebase

class SignUpPage: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
}

