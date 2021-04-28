//
//  SessionManager.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-27.
//

import Foundation

class SessionManager {
    
    
    func getLoggedState() -> Bool {
        return UserDefaults.standard.bool(forKey: "USER_LOGGED")
    }
    
    
    func saveUserLogin(){
        UserDefaults.standard.setValue(true, forKey: "USER_LOGGED")

    }
    
    func clearUserLoggedState(){
        UserDefaults.standard.setValue(false, forKey: "USER_LOGGED")
    }
}
