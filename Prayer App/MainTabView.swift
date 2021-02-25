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
    
    init(user: AuthUser) {
        self.user = user
        //bug here ^ No ObservableObject of type SessionData found even tho PrayerAppApp clearly has it
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
                .environmentObject(self.sessionData)
//            AccountView (user: user)
//                .tabItem {
//                    Image(systemName: "person.crop.circle")
//                    Text("Account")
//                }
//                .environmentObject(sessionManager)
            
           
            
        }
        .onAppear(perform: sessionData.updatePrayersFromAWS)
    }
}

extension MainTabView {
        
    
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
