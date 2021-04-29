//
//  CartViewController.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-28.
//

import UIKit
import Firebase
import Loaf

class CartViewController: UIViewController {

    @IBOutlet weak var tblCartItems: UITableView!
    
    var cartItems: [FoodItem] = []
    let sessionMGR = SessionManager()
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.cartItems = CartHandler.getCartItems()
        tblCartItems.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
    }
    

    @IBAction func onConfirmPressed(_ sender: UIButton) {
        saveOrder()
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CartViewController {
   func saveOrder() {
    
    var orderDate: [String: Any] = [:]
    var foodItemInfo: [String: Any] = [:]
    
    for index in 0..<cartItems.count {
        foodItemInfo.removeAll()
        foodItemInfo["foodName"] = cartItems[index].foodName
        foodItemInfo["foodDescription"] = cartItems[index].foodDescription
        foodItemInfo["foodPrice"] = cartItems[index].foodPrice
        orderDate["\(index)"] = foodItemInfo
    }
    
    var order: [String: Any] = [:]
    order["status"] = "pending"
    order["orderItems"] = orderDate
    
    
    self.ref.child("orders")
        .child(sessionMGR.getUserData().userEmail
                .replacingOccurrences(of: "@", with: "_")
                .replacingOccurrences(of: ".", with: "_"))
        .childByAutoId()
        .setValue(order) {
        (error, ref) in
        
        if let err = error {
            print(err.localizedDescription)
            Loaf("Order data not saved on database", state: .error, sender: self).show()
            return
        }
                    Loaf("Order data saved on database", state: .success, sender: self).show {
                        type in
                        CartHandler.clearCart()
                        self.dismiss(animated: true, completion: nil)
                    }
    }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCartItems.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifier", for: indexPath) as! FoodTableViewCell
        cell.setupView(foodItem: cartItems[indexPath.row])
        return cell
    }
    
    
}
