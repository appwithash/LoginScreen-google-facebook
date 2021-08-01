//
//  UserGoogleLoginManager.swift
//  DemoApp
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI
import GoogleSignIn
import Firebase
class UserGoogleLoginManager: ObservableObject{
   
//    func login(currentUser : Users) -> Users{
//        if GIDSignIn.sharedInstance().currentUser == nil {
//              GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
//              GIDSignIn.sharedInstance().signIn()
//            }
//        return currentUser
//    }
    
    func logout(){
        GIDSignIn.sharedInstance()?.signOut()
        try! Auth.auth().signOut()
    }
}
