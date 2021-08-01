//
//  UserFbloginManager.swift
//  DemoApp
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI
import FBSDKLoginKit
class UserFBLoginManager: ObservableObject {
    @AppStorage("login_status") var isLogin = false
    let loginManager = LoginManager()
    func facebookLogin(currentUser : Users) -> Users{
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(String(describing: accessToken))")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name"]).start( completion: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        currentUser.firstName=fbDetails.value(forKey: "first_name") as! String
                        currentUser.lastName=fbDetails.value(forKey: "last_name") as! String
                        print(fbDetails.value(forKey: "first_name") as! String)
                        print(fbDetails.value(forKey: "last_name") as! String)
                      
                        self.isLogin=true
                       
                    }
                })
            }
        }
        return currentUser
    }
}
