//
//  CreateUserView.swift
//  Prayer App
//
//  Created by tomrunnels on 3/23/21.
//

import SwiftUI
import Amplify

//from User class
        //public let id: String
        //public var username: String?
        //public var location: String?
        //public var fullName: String?
        //public var prayergroups: List<PrayerGroupUser>?
        //public var Prayers: List<Prayer>?

struct CreateUserView: View {
    
    var authUser: AuthUser

    @State var username = ""
    @State var location = ""
    @State var fullName = ""
    
    @State var feedback: String = ""
    
    @Binding var showThisView: Bool
    @Binding var sessionDataUser: User?
    @Binding var userLoaded: Bool
    
    var body: some View {
        FakeFormView(viewTitle: "Let's create your profile!") {
//            Text("We noticed you've never made profile for \(authUser.username), let's do that now").font(.subheadline).padding()
            
            
            Text(feedback)
                .frame(minHeight: 25)
            
            HStack {
                Text("Username".uppercased())
                    .font(Font.custom("SF Pro Text", size: 13.0))
                    .foregroundColor(.gray)
                    .padding(.leading)
                Spacer()
            }
            HStack {
                Text(authUser.username)
                    .padding([.bottom,], 20)
                    .padding([.leading], 30)
                    .padding(.top,4)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Spacer()
            }
            FakeFormField(sectionText: "Full Name (optional)", placeholderText: "John Doe", text: $fullName)
                .padding(.bottom, 20)
            FakeFormField(sectionText: "Location  (optional)", placeholderText: "Jupiter, FL", text: $location)
                .padding(.bottom, 20)
   

            
            
            Spacer()
                .frame(height:25)
            
            VStack {

                    Button(action: {
                        showThisView = !(handleCreateUser(_id: authUser.userId, _username: authUser.username, _location: location, _fullName: fullName, feedback: $feedback))
                    }
                    ){
                        Text("Submit")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color("Element"))
                        .cornerRadius(30)
                            .scaleEffect(1.2)
                    }
            
                Spacer()
                    
            }
        
        }
    }
    
    
    

    func handleCreateUser(_id: String, _username: String, _location: String?, _fullName: String?, feedback: Binding<String>) -> Bool {
        var returnBool = false
        var item = User(
                id: _id,
                username: _username,
                prayergroups: [],
                Prayers: [])
        
        _location != "" ? item.location = _location : nil
        _fullName != "" ? item.fullName = _fullName : nil

        
        
        Amplify.DataStore.save(item) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
                feedback.wrappedValue = "User created"
                returnBool = true
                sessionDataUser = item
                userLoaded = true
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
                feedback.wrappedValue = "\(error)"
                returnBool = false
            }
        }
        return returnBool
    }
    
    
}

struct CreateUserView_Previews: PreviewProvider {
    
    private struct leDummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "prayermaster500"
   }
    @State static var val = true
    @State static var usr : User? = nil
    @State static var load = false


    static var previews: some View {
        CreateUserView(authUser: leDummyUser(), showThisView: $val, sessionDataUser: $usr, userLoaded: $load)
    }
}
