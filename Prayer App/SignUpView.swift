//
//  SignUpView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/18/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins



struct SignUpView : View {
    @EnvironmentObject var sessionManager: AuthSessionManager
    
    @State var username : String    = ""
    @State var email : String    = ""
    @State var password : String    = ""
    @State var code : String    = ""

    @ObservedObject private var userData: UserData = .shared
    //@Binding var waiting : Bool = Backend.shared.$isWaitingToConfim
    
    var body: some View {
        VStack {
                    
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)
            TextField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                                    
            Button(action: {
                sessionManager.signUp(username: self.username, email: self.email, password: self.password)
                print("signing up: \(self.username)")
            }
            ){
                Text("Sign Up")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
                .scaleEffect(0.8)
            }

        }

    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
