//
//  SplashScreen.swift
//  LoginScreen
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var currentUser : Users
    @State var isDashboardAppeared = false
    @State var isActive = true
    @State var offset = true
    @AppStorage("login_status") var isLogin = false
    var body: some View {
        ZStack{
            if !isLogin{
            LinearGradient(gradient: Gradient(colors: [Color("lightPurple"), Color("violet")]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
                .opacity(isActive ? 1 : 0)
                .animation(Animation.default.speed(0.7))
           
           LoginScreenView().environmentObject(currentUser)
            .opacity(isActive ? 0 : 1)
            .animation(Animation.default.speed(0.7))
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Screen.maxWidth*0.5, height:  Screen.maxWidth*0.5, alignment: .center)
                    .padding(.bottom)
                    .offset(y:!isLogin && self.offset ? 0 : -Screen.maxHeight*0.3)
                    .animation(Animation.default.speed(0.7))
                    .opacity(!isActive && isDashboardAppeared ? 0 : 1)
                   
                    
                    
            }else{
                LinearGradient(gradient: Gradient(colors: [Color("lightPurple"), Color("violet")]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
                    .opacity(isActive ? 1 : 0)
                    .animation(Animation.default.speed(0.7))
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Screen.maxWidth*0.5, height:  Screen.maxWidth*0.5, alignment: .center)
                    .padding(.bottom)
              
                    .animation(Animation.default.speed(0.7))
                    .opacity(!isActive && isDashboardAppeared ? 0 : 1)
                DashboardScreen(isDashboardAppeared: $isDashboardAppeared)
                    .environmentObject(currentUser)
                    .opacity(isActive ? 0 : 1)
                    .animation(Animation.default.speed(0.7))
            }
            
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.offset=false
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2.5) {
                self.isActive=false
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView().environmentObject(Users())
    }
}
