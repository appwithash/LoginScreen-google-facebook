//
//  DashboardScreen.swift
//  LoginScreen
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI

struct DashboardScreen: View {
    @AppStorage("login_status") var isLogin = false
    @EnvironmentObject var currentUser : Users
    @Binding var isDashboardAppeared : Bool
    var body: some View {
        VStack{
            Spacer()
            Text("Welcome,\(currentUser.firstName) \(currentUser.lastName)")
                .font(.title2)
            Spacer()
            ZStack{
                Color("violet")
                Color("lightPurple").opacity(0.2)
                Text("Logout")
                    .foregroundColor(Color.white)
                
            }
            .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.06, alignment: .center)
            .cornerRadius(Screen.maxWidth*0.03)
                .onTapGesture {
                    self.isLogin=false
                    self.isDashboardAppeared=false
                }
            Spacer()
        }
        .environmentObject(currentUser)
        .onAppear{
            self.isLogin=true
            self.isDashboardAppeared=true
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen(isDashboardAppeared: .constant(true)).environmentObject(Users())
    }
}
