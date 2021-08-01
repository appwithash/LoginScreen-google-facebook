//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI
import FBSDKCoreKit
import Firebase
import GoogleSignIn
@main
struct DemoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            
            SplashScreenView().environmentObject(appDelegate.user).onAppear{
             
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    @AppStorage("login_status") var isLogin = false
    @ObservedObject var user = Users()
    var fullName=""
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
       FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().clientID = "498049937436-fl0hab8nmtudg5e0df8ca7kfh9jbhd64.apps.googleusercontent.com"
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        return true
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error.localizedDescription)
            return
        }
        let credentials = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
        Auth.auth().signIn(with: credentials) { (result, error) in
            if error != nil{
                print((error?.localizedDescription)!)
            }
            NotificationCenter.default.post(name: NSNotification.Name("SignIn"), object: nil)
        
            self.fullName = (result?.user.displayName)!
            let fullNameArr = self.fullName.split(separator: " ")
            self.user.firstName=String(fullNameArr[0])
            self.user.lastName=fullNameArr.count > 1 ? String(fullNameArr[fullNameArr.count-1]) : ""
            self.isLogin=true
            print("name- \(self.user.firstName) \(self.user.lastName)")
        }
        
    }
    
   
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }

}
    
