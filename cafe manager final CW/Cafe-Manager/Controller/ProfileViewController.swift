//
//  ProfileViewController.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-28.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let sessionMGR = SessionManager()

    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = sessionMGR.getUserData()
        txtUsername.text = user.userName
        txtEmail.text = user.userEmail
        txtPhone.text = user.userPhone
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignOutPressed(_ sender: UIButton) {
        
        sessionMGR.clearUserLoggedState()
    }
    

}
