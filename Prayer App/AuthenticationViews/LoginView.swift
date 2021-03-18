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
        
        FakeFormView(viewTitle: "Log In", spacer: 40) {
        
        
            FakeFormField(sectionText: "Username", placeholderText: "prayermaster500", text: $username)
                .padding(.bottom, 20)
            FakeFormField(sectionText: "Password", placeholderText: "PM501pa$$", text: $password)
                .padding(.bottom, 20)
        
                    
            VStack {
                Button(action: {
                    loginViewModel.login(completion: onLogin, username: self.username, password: self.password)
                    print("signing in: \(self.username)")
                }
                ){
                    HStack {
                        Image(systemName: "person.fill")
                            .scaleEffect(1.5)
                            .padding()
                            .foregroundColor(.black)
                        Text("Log In")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Element"))
                    .cornerRadius(30)
                    .scaleEffect(0.75)
                }
                .sheet(isPresented: $showSignUpView) {
                    FlowSignUpAndConfrim()
                }
                
                
                
                Spacer()
                    

                
                Button(action: {
                    print("login screen: sign up pressed")
                    self.showSignUpView.toggle()
                }, label: {
                    Text("Don't have an account?  Sign Up here")

                }).padding(.bottom)

            } //vstack
            
        
        } //end of FakeForm
        
    
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
            
//
//            Amplify.Auth.signIn(username: username, password: password)
//                .resultPublisher
//                .sink {
//                    if case let .failure(authError) = $0 {
//                        print("Sign in failed \(authError)")
//                    }
//                }
//                receiveValue: { _ in
//                    print("Sign in succeeded")
//                }
            
            
                Amplify.Auth.signIn(username: username, password: password) { result in
                    switch result {
                    case .success:
                        print("Sign in succeeded")
                    case .failure(let error):
                        print("Sign in failed \(error)")
                    }
                }

            
            if let gotUser = Amplify.Auth.getCurrentUser() {
                print("Session with user: " + gotUser.username + " begins.")
                completion(gotUser)
                
            }
            
          
        }
    }
}



struct LoginView_Previews: PreviewProvider {
//
//    @StateObject var sessionData = SessionData()

    
    static var previews: some View {
        LoginView { user in
            var _ = user
        }
    }
}







//footnotes
// (1)    https://docs.amplify.aws/lib/auth/signin/q/platform/ios#sign-in-a-user
