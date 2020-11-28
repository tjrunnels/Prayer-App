//
//  AccountView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify

struct AccountView: View {
    @EnvironmentObject var sessionManager : AuthSessionManager
    let user: AuthUser
    
    var body: some View {
        VStack{
            Text("Hello, \(user.username) !").font(.largeTitle).padding(.all, 40)
            Text("ID: \(user.userId)").font(.body).foregroundColor(.gray)
            Spacer()
            
            Button(action: {
                sessionManager.signOut()
            }
            ){
                Text("Sign Out")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
                .scaleEffect(1.0)
            }
            .padding(.bottom,50)
        }
        
    }
    
    
}

struct AccountView_Previews: PreviewProvider {
    private struct leDummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummyUser"
   }
    
    static var previews: some View {
        AccountView(user: leDummyUser())
    }
}
