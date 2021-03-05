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
    @StateObject var sessionData = SessionData()

    let user: AuthUser
    @State var showAdd: Bool = true
    
    
    
 
    
    var body: some View {
        TabView{
            UserView (user: self.user)
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
                .environmentObject(self.sessionData)
            
            
            GroupsView(user: user)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Groups")
                }
                .environmentObject(authSessionManager)
                .environmentObject(self.sessionData)
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
