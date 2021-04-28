//
//  SignUpViewController.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-16.
//

import UIKit
import Firebase
import Loaf

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        if validateInput() {
            registerUser(email: txtEmail.text!, password: txtPassword.text!)
        }
        else{
            print("Input error found")
        }
    }
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                Loaf("User sign up failed!", state: .error, sender: self).show()
                return
            }
            
            if let result = authResult{
                print("User added with Email: \(result.user.email ?? "Not Found")")
                Loaf("User registered successfully!", state: .success, sender: self).show()
            }
            
        }
    }
    
    func validateInput() -> Bool{
        
        guard let name = txtname.text else{
            print("Name is NULL")
            return false
        }
        
        guard let email = txtEmail.text else{
            print("Email is NULL")
            return false
        }
        
        guard let phone = txtPhone.text else{
            print("Phone is NULL")
            return false
        }
        
        guard let password = txtPassword.text else{
            print("Password is NULL")
            return false
        }
        
        if name.count < 5 {
            print("Enter a valid name")
            return false
        }
        
        if email.count < 5 {
            print("Enter a valid email")
            return false
        }
        
        if phone.count < 10 {
            print("Enter a valid phone")
            return false
        }
        
        if password.count < 5 {
            print("Enter a valid password")
            return false
        }
        
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
