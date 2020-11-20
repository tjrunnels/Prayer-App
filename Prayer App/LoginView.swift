//
//  LoginView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/18/20.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionManager: AuthSessionManager


    @State var username : String    = ""
    @State var password : String    = ""
    @ObservedObject private var userData: UserData = .shared

    @State var showSignUpView = false

    var body: some View {
        VStack {
                    
            Text("Sign In")
                .font(.largeTitle)
                .bold()
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)
            TextField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                    
                    
            if(self.userData.currentError != "") {
                Text(self.userData.currentError).font(.footnote).foregroundColor(.red).padding()
            }
                    
            Button(action: {
                sessionManager.login(username: self.username, password: self.password)
                print("signing in: \(self.username)")
            }
            ){
                HStack {
                    Image(systemName: "person.fill")
                        .scaleEffect(1.5)
                        .padding()
                    Text("Sign In")
                        .font(.largeTitle)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
                .scaleEffect(0.8)
            }
            Button(action:
                    {
                        sessionManager.showSignUP() //tomdo: change to sheet?
                         
                    }) {
                Text("Sign Up")
            }
            
        }.sheet(isPresented: $showSignUpView) {
            SignUpView()
        }
    }


    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
