//
//  ForgetPasswordViewController.swift
//  CafeManager
//
//  Created by Lionel Rajapakse on 2021-04-30.
//

import UIKit
import Firebase
import Loaf

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmailAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: txtEmailAddress.text!) { (error) in
            if let error = error{
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let alert = Service.createAlertController(title: "Hurray", message: "A password reset email has been sent!")
            self.present(alert, animated: true, completion: nil)
        }
    
    }
}
