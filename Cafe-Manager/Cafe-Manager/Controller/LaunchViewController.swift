//
//  LaunchViewController.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-28.
//

import UIKit

class LaunchViewController: UIViewController {

    let sessionMGR = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if sessionMGR.getLoggedState() {
            self.performSegue(withIdentifier: "LaunchToHome", sender: nil)
        }
        else{
            self.performSegue(withIdentifier: "LaunchtoSignIn", sender: nil)
        }
    }
    

    

}
