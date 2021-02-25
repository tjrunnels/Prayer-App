//
//  UserView.swift
//  Prayer App
//
//  Created by tomrunnels on 2/17/21.
//

import SwiftUI

struct UserView: View {
    let user: User
    @EnvironmentObject var sessionManager : AuthSessionManager

    
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
                    .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .top)
                    .shadow(color: Color("Shadow"), radius: 8, x: 8, y: 8)
                    
                    

                VStack{
                    HStack{
                        Circle().frame(width: 80, height: 80, alignment: .leading)
                        VStack{
                            Text("@" + user.username).font(.title).padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            Text(user.State +  ", " + user.Country).font(.caption)
                        }
                    }
                    HStack{
                        
                        //add friend button
                        Button(action: {
                            print("Signing Out")
                            sessionManager.signOut()
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
            
            
            Spacer()
            
        }
        
    }
    }
    
    
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

    static var previews: some View {
        Group {
            UserView(user: prayerUser)
                
                
        }
    }
}
