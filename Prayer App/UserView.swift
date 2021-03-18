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
    @EnvironmentObject var sessionManager : AuthSessionManager
    @State var currentUserInfo: User?
    
    @State var feedback: String = ""
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Background"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
       
        VStack{
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Element"))
                    .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: .top)
                    .shadow(color: Color("Shadow"), radius: 8, x: 8, y: 8)
                    
                    

                VStack{
                    HStack{
                        Circle().frame(width: 80, height: 80, alignment: .leading)
                        VStack{
                            
                            currentUserInfo?.fullName != nil
                                ? Text(currentUserInfo!.fullName!).font(.title)
                                : Text("")
                            
                            currentUserInfo?.username != nil
                                ? Text("@" + currentUserInfo!.username!).font(.subheadline)
                                : Text("Error loading User")
                            
                            
                            currentUserInfo?.location != nil
                                ? Text(currentUserInfo!.location!).font(.subheadline)
                                : Text("")
                            
                            currentUserInfo?.id != nil
                                ? Text(currentUserInfo!.id).font(.caption2)
                                : Text("")
                        }
                    }
                    HStack{
                        
                        //add friend button
                        Button(action: {
                            print("Signing Out")
                            sessionManager.signOut()
                            feedback = "signed out.  please restart the app"
                            //TODO: switch view to Login
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color("Background"))
                                    .frame(width: 150, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                HStack {
                                    Image(systemName: "person.badge.plus")
                                    Text("Sign Out")
                                }
                            }
                        }
                        
                    }
                }.padding(.top, 30)
                
            }.ignoresSafeArea(.container, edges: .top)
            
            
            Text(feedback).padding()

            if(currentUserInfo == nil) {
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
            
        }
        
        }.onAppear(perform: {
            print("getting User")
            
            //TODO: right now this view finds the user itself, change this to getting it from sessionData
            
            Amplify.DataStore.query(User.self).sink {
                if case let .failure(error) = $0 {
                       print("Error on query() for type User - \(error.localizedDescription)")
                   }
            } receiveValue: { queryUsers in
                for queryUser in queryUsers {
                    print("AYO: " + queryUser.id + " vs " + user.userId)  //tomdo: change this query to just get the one we need
                    if(queryUser.id != nil && queryUser.id == self.user.userId) {
                        currentUserInfo = queryUser
                        print("GOT USER: " + queryUser.id)
                    }
                }
              
                
            }
                    
            //a3f4095e-39de-43d2-baf4-f8c16f0f6f4d   2784f490-f16f-4375-8efc-2cdf0272e188
            
//            Amplify.DataStore.query(User.self, byId: user.userId).sink {
//                if case let .failure(error) = $0 {
//                       print("Error on query() for type User - \(error.localizedDescription)")
//                   }
//            } receiveValue: { user in
//                currentUserInfo = user
//                print("GOT USER! ")
//            }
            
        
        
        
        })
    }//end of body
    
    
    
}

//
//extension GraphQLRequest {
//    static func getOneUserInfo(byId id: String) -> GraphQLRequest<User> {
//        let operationName = "getUser"
//        let document = """
//            query getOneUserInfo($id: ID!) {
//              \(operationName)(id: $id) {
//                fullName
//                id
//                location
//                username
//              }
//            }
//            """
//        return GraphQLRequest<User>(document: document,
//                                    variables: ["id": id],
//                                    responseType: User.self,
//                                    decodePath: operationName)
//    }
//}




//
//var id: String
//var username: String
//var name: String
//var Country: String
//var State: String
//var isPlus: Bool
//var isDonor: Bool
//var iconName: String


//tomdo: fix and uncomment
//struct UserView_Previews: PreviewProvider {
//
//    private struct leDummyUser: AuthUser {
//       let userId: String = "1"
//       let username: String = "dummyUser"
//   }
//
//    static var previews: some View {
//        Group {
//            UserView(user: leDummyUser)
//
//        }
//    }
//}
