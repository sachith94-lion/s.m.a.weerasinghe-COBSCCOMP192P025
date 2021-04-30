//
//  SessionManager.swift
//  CafeManager
//
//  Created by Lionel Rajapakse on 2021-04-30.
//

import Foundation

class SessionManager {
    
    
    func getLoggedState() -> Bool {
        return UserDefaults.standard.bool(forKey: "USER_LOGGED")
    }
    
    
    func saveUserLogin(user: User){
        UserDefaults.standard.setValue(true, forKey: "USER_LOGGED")
        UserDefaults.standard.setValue(user.userName, forKey: "USER_NAME")
        UserDefaults.standard.setValue(user.userEmail, forKey: "USER_EMAIL")
        UserDefaults.standard.setValue(user.userPhone, forKey: "USER_PHONE")

    }
    
    func getUserData() -> User {
        let user = User(
            userName: UserDefaults.standard.string(forKey: "USER_NAME") ?? "",
            userEmail: UserDefaults.standard.string(forKey: "USER_EMAIL") ?? "",
            userPassword: "",
            userPhone: UserDefaults.standard.string(forKey: "USER_PHONE") ?? "")
        return user
    }
    
    func clearUserLoggedState(){
        UserDefaults.standard.setValue(false, forKey: "USER_LOGGED")
    }
}
