//
//  UserView.swift
//  Prayer App
//
//  Created by tomrunnels on 2/17/21.
//

import SwiftUI
import Amplify
import Foundation



struct UserView: View {
    
    let user: AuthUser
    @EnvironmentObject var authSessionManager : AuthSessionManager //just used for signout function
    @EnvironmentObject var sessionData: SessionData //used for user info
    
    @State var feedback: String = ""
    
    
    var body: some View {
        ZStack {
            
            //grey background
            Rectangle()
                .fill(Color(.systemGray6))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
       
            VStack{
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Element"))
                        .frame(width: UIScreen.main.bounds.size.width, height: 260, alignment: .top)
                        .shadow(color: Color("Shadow"), radius: 8, x: 8, y: 8)
                        
                        

                    VStack{
                        VStack{
                            
                            //QR Code  //TODO: make this generate programatically
                            Image("QR_Test_Transparent").resizable()
                                .frame(width: 120, height: 120, alignment: .leading)
                                .cornerRadius(10)
                                .padding(.top)
           
                                
                            //Full Name
                            sessionData.currentUser?.fullName != nil
                                ? Text(sessionData.currentUser!.fullName!).font(.title)
                                : Text("")
                            
                            //Username ᐧ Location
                            HStack {
                                sessionData.currentUser?.username != nil
                                    ? Text("@" + sessionData.currentUser!.username!).font(.subheadline)
                                    : Text("Error loading User")
                                
                                Text("ᐧ")

                                sessionData.currentUser?.location != nil
                                    ? Text(sessionData.currentUser!.location!).font(.subheadline)
                                    : Text("")
                            }
                            
//                            #if DEBUG
//                            sessionData.currentUser?.id != nil
//                                ? Text("$ " + sessionData.currentUser!.id).font(.caption2)
//                                : Text("")
//                            #endif
                       
                        
                        } //little Vstack
                        
                    }//big vstack
                    .padding(.top, 30)
                    
                }//zstack
                .ignoresSafeArea(.container, edges: .top)
                
               
         
                
                
                Text(feedback).padding()

                
                //debug feedback
                if(sessionData.currentUser == nil) {
                    Button(action: {
                        
                        let item = User(id: user.userId, username: user.username)
                        Amplify.DataStore.save(item) { result in
                            switch(result) {
                            case .success(let savedItem):
                                print("Saved item: \(savedItem.id)")
                                feedback = "user created, please restart the app"
                            case .failure(let error):
                                print("Could not save item to DataStore: \(error)")
                                feedback = "user creation failed, see log for error"
                            }
                        }
                        
                        
                    }, label: {
                        Text("create a PrayerApp User for \(user.username)")
                    })
                }
                
                Spacer()
                Spacer()
                Spacer()

                
                HStack{     //Sign Out Button
                    
                    //add friend button
                    Button(action: {
                        print("Signing Out")
                        authSessionManager.signOut()
                        feedback = "signed out.  please restart the app"
                        //TODO: switch view to Login
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color("Background"))
                                .frame(width: 150, height: 30, alignment: .center)
                            HStack {
                                Image(systemName: "person.badge.plus")
                                Text("Sign Out")
                            }
                        }
                    }
                    
                }
                
                Spacer()

                
            } //Vstack
        
        } //end of zstack
        .onAppear(perform: {
            
        })
        
        
    }//end of body
    
    
    
}



//
//var id: String
//var username: String
//var name: String
//var Country: String
//var State: String
//var isPlus: Bool
//var isDonor: Bool
//var iconName: String


struct UserView_Previews: PreviewProvider {

    private struct leDummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummyUser"
   }

    static var previews: some View {
        Group {
            UserView(user: leDummyUser())
                .environmentObject(SessionData(createUser:
                                                User(
                                                    id: "ID_testingUser1234",
                                                    username: "Gandalf500",
                                                    location: "Middle Earth",
                                                    fullName: "Gandalf The Grey"
                                                    //,prayergroups: <#T##List<PrayerGroupUser>?#>
                                                    //,Prayers: <#T##List<Prayer>?#>
                                                )
                                              )
                                 )
        }
    }
}
