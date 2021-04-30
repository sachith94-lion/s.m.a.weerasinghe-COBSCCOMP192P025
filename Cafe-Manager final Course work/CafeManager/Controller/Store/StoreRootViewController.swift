//
//  StoreRootViewController.swift
//  CafeManagerTest
//
//  Created by sachith weerasinghe on 2021-04-29.
//

import UIKit

class StoreRootViewController: UIViewController {
    
    var tabBarContainer: UITabBarController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tarBarSegue" {
            self.tabBarContainer = segue.destination as? UITabBarController
        }
        self.tabBarContainer?.tabBar.isHidden = true
    }

    @IBAction func onSegIndexChanged(_ sender: UISegmentedControl) {
        tabBarContainer?.selectedIndex = sender.selectedSegmentIndex
    }
}
