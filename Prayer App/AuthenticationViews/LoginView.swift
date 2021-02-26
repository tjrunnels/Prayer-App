//
//  LoginView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/18/20.
//

import SwiftUI
import Amplify

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()

    @State var username : String    = ""
    @State var password : String    = ""
    @State var showSignUpView = false

    let onLogin: (AuthUser) -> Void
    
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
                    
//
//            if(self.userData.currentError != "") {
//                Text(self.userData.currentError).font(.footnote).foregroundColor(.red).padding()
//            }
                    
            Button(action: {
                loginViewModel.login(completion: onLogin, username: self.username, password: self.password)
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
//            Button(action:
//                    {
//                        sessionManager.showSignUP() //tomdo: change to sheet?
//
//                    }) {
//                Text("Sign Up")
//            }
            
        }.sheet(isPresented: $showSignUpView) {
            SignUpView()
        }
    } //end of body

}//end of View

extension LoginView {
    class LoginViewModel: ObservableObject {
        @Published var username = String()
        
        func login(completion: @escaping (AuthUser) -> Void, username: String, password: String) {
            print("attempting Sign in of " + username)
            
            
            
            //Sign in failed AuthError: There is already a user which is signed in. Please log out the user before calling showSignIn.
            //Recovery suggestion: Operation performed is not a valid operation for the current auth state
            //from (1)
            Amplify.Auth.signIn(username: username, password: password)
                .resultPublisher
                .sink {
                    if case let .failure(authError) = $0 {
                        print("Sign in failed \(authError)")
                    }
                }
                receiveValue: { _ in
                    print("Sign in succeeded")
                }
            
            if let gotUser = Amplify.Auth.getCurrentUser() {
                print("Session with user: " + gotUser.username + " begins.")
                completion(gotUser)
                
            }
            
          
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}







//footnotes
// (1)    https://docs.amplify.aws/lib/auth/signin/q/platform/ios#sign-in-a-user
