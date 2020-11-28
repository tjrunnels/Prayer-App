//
//  MainTabView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/27/20.
//

import SwiftUI
import Amplify

struct MainTabView: View {
    @EnvironmentObject var sessionManager : AuthSessionManager
    @ObservedObject private var sessionData: SessionData = .shared

    let user: AuthUser
    
    init(user: AuthUser) {
        AWS_Backend.shared.updateSessionData(withSignInStatus: true)
        self.user = user
    }
    
    var body: some View {
        TabView{
            AddPrayerView(sessionData: self.sessionData, user: user)
                .tabItem {
                    Image(systemName: "text.bubble")
                    Text("Prayer")
                }
            ListPrayersView(sessionData: sessionData)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
                .environmentObject(sessionManager)
            
            
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
