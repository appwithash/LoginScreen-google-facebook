//
//  ContentView.swift
//  LoginScreen
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI
import FBSDKLoginKit
import GoogleSignIn
import Firebase
struct LoginScreenView: View {
    @EnvironmentObject var currentUser : Users
   @State var username = ""
    @State var password = ""
    @State var showPassword = false
    @ObservedObject var fbmanager = UserFBLoginManager()
    @ObservedObject var gManager = UserGoogleLoginManager()
    @State var user = Auth.auth().currentUser
    var fbButton = FBLoginButton()
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .opacity(0.8)
                .scaledToFill()
                .ignoresSafeArea()
            Color("purple")
                .opacity(0.8)
                .blendMode(.multiply)
                .ignoresSafeArea()
            
            VStack(alignment : .leading,spacing:Screen.maxWidth*0.05){
                
            Text("Login")
                .bold()
                .font(.system(size: 35))
                .foregroundColor(.white)
                VStack(alignment:.leading,spacing:Screen.maxWidth*0.04){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: Screen.maxWidth*0.03)
                            .stroke(Color.white)
                        Text("Email")
                            .foregroundColor(.white)
                            .opacity(self.username.isEmpty ? 0.6 : 0)
                            .padding(.trailing,Screen.maxWidth*0.75)
                        TextField("",text:$username)
                            .foregroundColor(.white)
                            .padding(.leading,Screen.maxWidth*0.02)
                        
                    }.frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.06, alignment: .center)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: Screen.maxWidth*0.03)
                            .stroke(Color.white)
                        Text("password")
                            .foregroundColor(.white)
                            .opacity(self.password.isEmpty ? 0.6 : 0)
                            .padding(.trailing,Screen.maxWidth*0.67)
                        HStack{
                            if showPassword{
                                TextField("",text:$password)
                                    .padding(.leading,Screen.maxWidth*0.02)
                                    .foregroundColor(.white)
                            }else{
                                SecureField("",text:$password)
                                    .foregroundColor(.white)
                                    .padding(.leading,Screen.maxWidth*0.02)
                            }
                            Image(systemName:self.showPassword ? "eye" : "eye.slash")
                                
                                .foregroundColor(.white)
                                .opacity(0.7)
                                .onTapGesture {
                                    self.showPassword.toggle()
                                }
                        }.padding(.leading).padding(.trailing)
                    }.frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.06, alignment: .center)
                    
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            Color("violet")
                            Color("lightPurple").opacity(0.2)
                            Text("Login")
                                .foregroundColor(Color.white)
                            
                        }
                        .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.06, alignment: .center)
                        .cornerRadius(Screen.maxWidth*0.03)
                    })
                    
                    Text("Other").bold()
                        .foregroundColor(.white)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                           let user =  self.fbmanager.facebookLogin(currentUser: currentUser)
                            currentUser.firstName = user.firstName
                            currentUser.lastName=user.lastName
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: Screen.maxWidth*0.04)
                                Text("f")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.largeTitle)
                            }.frame(width: Screen.maxHeight*0.06, height: Screen.maxHeight*0.06, alignment: .center)
                        })
                        Spacer()
                        Button(action: {
                            GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
                            GIDSignIn.sharedInstance().signIn()
                        }, label: {
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: Screen.maxWidth*0.04)
                                Image("google_logo")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: Screen.maxHeight*0.06, height: Screen.maxHeight*0.06, alignment: .center)
                            .foregroundColor(.white)
                        })
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: Screen.maxWidth*0.04)
                                Image("apple_logo")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: Screen.maxHeight*0.06, height: Screen.maxHeight*0.06, alignment: .center)
                            .foregroundColor(.white)
                        })
                        Spacer()
                    }   .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.06, alignment: .center)
                }
                
            }
        }.environmentObject(currentUser)
        .onAppear{
            NotificationCenter.default.addObserver(forName: NSNotification.Name("SignIn"), object: nil, queue: .main) { (_) in
                self.user=Auth.auth().currentUser
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView().environmentObject(Users())
    }
}
