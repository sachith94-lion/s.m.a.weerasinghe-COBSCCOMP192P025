//
//  SignInViewController.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-16.
//

import UIKit
import Firebase
import Loaf

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    var number: Int?
    var fetchedNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        if validateInput(){
            authenticateUser(email: txtEmail.text!, password: txtPassword.text!)
            
        } else {
            print("INput error found")
        }
    }
    
    func validateInput() -> Bool {
        
        guard let email = txtEmail.text else {
            print("Email is NULL")
            return false
        }
        
        guard let password = txtPassword.text else{
            print("Password is NULL")
            return false
        }
        
        if email.count < 5 {
            print("Enter a valid Email")
            return false
        }
        
        if password.count < 5 {
            print("Enter a valid Password")
            return false
        }
        return true
    }
    
    func authenticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            
            if let err = error {
                print(err.localizedDescription)
                Loaf("User name or password is invalid", state: .error, sender: self).show()
                return
            }
            
            //save user logged in state
            let sessionManager = SessionManager()
            sessionManager.saveUserLogin()
            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
        }
    }
    
   

}
