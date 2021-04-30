//
//  SignInViewController.swift
//  CafeManager
//
//  Created by Lionel Rajapakse on 2021-04-30.
//

import UIKit
import Firebase
import Loaf

class SignInViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var number: Int?
    var fetchedNumber: Int = 0

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignInPressed(_ sender: UIButton) {
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf("Invalid email address!", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("Invalid Password", state: .error, sender: self).show()
            return
        }
        authenticateUser(email: txtEmail.text!, password: txtPassword.text!)
    }
    
    func authenticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            
            if let err = error {
                print(err.localizedDescription)
                Loaf("User name or password is invalid", state: .error, sender: self).show()
                return
            }
            
            if let email = authResult?.user.email {
                self.getUserData(email: email)
            }
            else{
                Loaf("User email not found", state: .error, sender: self).show()
            }
            
            
        }
    }
    
    func getUserData(email: String) {
        ref.child("users")
            .child(email
                    .replacingOccurrences(of: "@", with: "_")
                            .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
            (snapshot) in
                                
                                if snapshot.hasChildren() {
                                    if let data = snapshot.value {
                                        if let userData = data as? [String: String]{
                                            
                                            let user = User(
                                                userName: userData["userName"]!,
                                                userEmail: userData["userEmail"]!,
                                                userPassword: userData["userPassword"]!,
                                                userPhone: userData["userPhone"]!)
                                            
                                            let sesstionMGR = SessionManager()
                                            sesstionMGR.saveUserLogin(user: user)
                                            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
                                        }
                                    }
                                }
                                else{
                                    Loaf("User not found", state: .error, sender: self).show()
                                }
   
        })

    }
    

}
