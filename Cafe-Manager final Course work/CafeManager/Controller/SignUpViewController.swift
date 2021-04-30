//
//  SignUpViewController.swift
//  CafeManager
//
//  Created by Lionel Rajapakse on 2021-04-30.
//

import UIKit
import Firebase
import Loaf

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        
        if !InputValidator.isValidName(name: txtname.text ?? ""){
            Loaf("Invalid Name", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf("Invalid email address!", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidMobileNo(txtPhone.text ?? ""){
            Loaf("Invalid phone number", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("Invalid Password", state: .error, sender: self).show()
            return
        }
        
        let user = User(userName: txtname.text ?? "", userEmail: txtEmail.text ?? "",  userPassword: txtPassword.text ?? "", userPhone: txtPhone.text ?? "")
        
        registerUser(user: user)
        
        
    }
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registerUser(user: User) {
        Auth.auth().createUser(withEmail: user.userEmail , password: user.userPassword) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                Loaf("User sign up failed!", state: .error, sender: self).show()
                return
            }
            
            
            
            
            self.saveUserData(user: user)
            
        }
    }
    
    func saveUserData(user: User) {
        
        let userData = [
            "userName" : user.userName,
            "userEmail" : user.userEmail,
            "userPhone" : user.userPhone,
            "userPassword" : user.userPassword
        ]
        
        self.ref.child("users")
            .child(user.userEmail.replacingOccurrences(of: "@", with: "_")
                    .replacingOccurrences(of: ".", with: "_")).setValue(userData) {
            (error, ref) in
            
            if let err = error {
                print(err.localizedDescription)
                Loaf("User data not saved on database", state: .error, sender: self).show()
                return
            }
                        Loaf("User data saved on database", state: .success, sender: self).show {
                            type in
                            self.dismiss(animated: true, completion: nil)
                        }
        }
    }
}
