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

    let authUser: AuthUser
    @State var showAdd: Bool = true
    
    @State var apiUserLoaded = false
    @State var apiUserNonExistant = false
    
    @State var feedback = ""
    
    
    func loadUser (userIDFromAuth: String) -> Bool {
        var returnBool = false
        Amplify.DataStore.query(
                User.self,
                where: User.keys.id == userIDFromAuth
            ) { result in
            do {
                let thisUser = try result.get()
                print("prayers datastore query results: ")
                print(thisUser)
                if(thisUser.count < 1) {
                    print("WARNING: found no Users from id: " + userIDFromAuth)
                    returnBool = false
                }
//                DispatchQueue.main.async { }
                else {
                    if(thisUser.count > 1) {
                        print("WARNING: found multiple Users from id: " + userIDFromAuth )
                        //might be fine, grab the first user
                    }
                    sessionData.currentUser = thisUser.first
                    returnBool = true
                    apiUserLoaded = true
                    print("User has been loaded:::\(userIDFromAuth)")
                }
                
            } catch {
                returnBool = false
                print(error)
            }
        }
        return returnBool
    }

    
    
 
    
    var body: some View {
        
        
          switch (apiUserLoaded) {
              case false:
                VStack {
                    
                    //ProgressView(value: 0.4).shadow(color: .red, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    Text("Loading...")
                        .onAppear(perform: {
                            
                            //ideally, this view is never loaded withouth an AuthUser (see Prayer_AppApp (1))
                                //i would check again with && authUser.userid == nil but it might cause problems
                            if(loadUser(userIDFromAuth: authUser.userId) == false) {
                                apiUserNonExistant = true
                            }
                            
                        })
                        .onTapGesture {
                            feedback = "authUser: \(authUser.username ?? authUser.userId)...user: \(sessionData.currentUser?.username ?? "nil")"
                        }
                        .sheet(isPresented: $apiUserNonExistant) {
                            CreateUserView(authUser: self.authUser, showThisView: $apiUserNonExistant, sessionDataUser: $sessionData.currentUser, userLoaded: $apiUserLoaded)
                        }
                    
                    Text(feedback).font(.caption)
                        
                }
                
              default:
                TabView{
                    ListPrayersView(authuser: authUser)
                        .tabItem {
                            Image(systemName: "mail.stack")
                            Text("Prayers")
                        }
                        .environmentObject(authSessionManager)
                        .environmentObject(self.sessionData)
                    
                    
                    
                    GroupsView(user: authUser)
                        .tabItem {
                            Image(systemName: "person.3.fill")
                            Text("Groups")
                        }
                        .environmentObject(authSessionManager)
                        .environmentObject(self.sessionData)
                    
                    
                    
                    UserView (user: self.authUser)
                        .tabItem {
                            Image(systemName: "person.2.circle")
                            Text("User")
                        }
                        .environmentObject(authSessionManager)
                        .environmentObject(self.sessionData)

                    
                    
                    
                }//tabview
                
                
                // this blocks the taps from registering normally for some reason
        //        .onTapGesture {
        //            let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
        //                    impactHeavy.impactOccurred()
        //        }
                
           
          }//switch
    
    } //body

} //struct




//struct MainTabView_Previews: PreviewProvider {
//    private struct leDummyUser: AuthUser {
//       let userId: String = "1"
//       let username: String = "dummyUser"
//   }
//
//    static var previews: some View {
//        MainTabView(user: leDummyUser())
//    }
//}
