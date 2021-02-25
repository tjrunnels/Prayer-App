//
//  MainTabView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/27/20.
//

import SwiftUI
import Amplify

struct MainTabView: View {
    @EnvironmentObject var authSessionManager : AuthSessionManager
    @ObservedObject private var sessionData: SessionData = .shared

    let user: AuthUser
    @State var showAdd: Bool = true
    
    init(user: AuthUser) {
        AWS_Backend.shared.updateSessionData(withSignInStatus: true)
        self.user = user
    }
    
    var body: some View {
        TabView{
            UserView (user: prayerUser)
                .tabItem {
                    Image(systemName: "person.2.circle")
                    Text("User")
                }
                .environmentObject(authSessionManager)
            
            
            ListPrayersView(user: user)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
                .environmentObject(authSessionManager)
//            AccountView (user: user)
//                .tabItem {
//                    Image(systemName: "person.crop.circle")
//                    Text("Account")
//                }
//                .environmentObject(sessionManager)
            
           
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    private struct leDummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummyUser"
   }
    
    static var previews: some View {
        MainTabView(user: leDummyUser())
    }
}
