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
    
    
    
    func loadUser (userIDFromAuth: String) {
        Amplify.DataStore.query(
                User.self,
                where: User.keys.id == userIDFromAuth
            ) { result in
            do {
                let thisUser = try result.get()
                print("prayers datastore query results: ")
                print(thisUser)
                if(thisUser.count > 1) {print("WARNING: found multiple Users from id: " + userIDFromAuth )}
                DispatchQueue.main.async {
                    sessionData.currentUser = thisUser.first
                }
            } catch {
                print(error)
            }
        }
    }

    
    
 
    
    var body: some View {
        TabView{

            
            ListPrayersView(user: user)
                .tabItem {
                    Image(systemName: "mail.stack")
                    Text("Prayers")
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
            
            
            UserView (user: self.user)
                .tabItem {
                    Image(systemName: "person.2.circle")
                    Text("User")
                }
                .environmentObject(authSessionManager)
                           
           
            
        }//tabview
        .onAppear(perform: {
            loadUser(userIDFromAuth: user.userId)
        })
        
        // this blocks the taps from registering normally for some reason
//        .onTapGesture {
//            let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
//                    impactHeavy.impactOccurred()
//        }
        
   
    
    
    } //body

} //struct




struct MainTabView_Previews: PreviewProvider {
    private struct leDummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummyUser"
   }
    
    static var previews: some View {
        MainTabView(user: leDummyUser())
    }
}
