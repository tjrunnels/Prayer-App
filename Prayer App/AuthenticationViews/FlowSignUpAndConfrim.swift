//
//  FlowSignUpAndConfrim.swift
//  Prayer App
//
//  Created by tomrunnels on 3/18/21.
//

import SwiftUI
import Combine
import Amplify
import AmplifyPlugins



struct FlowSignUpAndConfrim: View {
    @EnvironmentObject var sessionManager: AuthSessionManager
    
    @State var username : String    = ""
    @State var email : String    = ""
    @State var password : String    = ""
    @State var code : String    = ""
    
    @State var isConfirmView = false


//    @ObservedObject private var userData: SessionData = .shared
    
    var body: some View {
        
        switch (isConfirmView) {
        
        //if confirm is not ready, show signup
        case false:
            FakeFormView(viewTitle: "Sign Up", spacer: 40) {
            
 
                FakeFormField(sectionText: "Username", placeholderText: "prayermaster500", text: $username)
                    .padding(.bottom, 20)
                FakeFormField(sectionText: "Email", placeholderText: "pm500@gmail.com", text: $email)
                    .padding(.bottom, 20)
                FakeFormField(sectionText: "password", placeholderText: "PM501pa$$", text: $password)
                    .padding(.bottom, 20)

                
                
                Spacer()
                    .frame(height:25)
                                        
                VStack {

                        Button(action: {
//                            if(sessionManager.signUp(username: self.username, email: self.email, password: self.password)) {
//                                self.isConfirmView = true
//                                print("signup of \(username) successful, moving to confirmation")
//                            }
//                            else {
//                                print("signup of \(username) failed")
//                            }
                            
                            handleSignUp(username: self.username, password: self.password, email: self.email)
                        
                            isConfirmView = true
                           // print("signing up: \(self.username)")
                        }
                        ){
                            Text("Sign Up")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color("Element"))
                            .cornerRadius(30)
                                .scaleEffect(1.2)
                        }
                
                    Spacer()
                        

                    Button(action: {
                        print("login pressed on signin screen")
                        
                    }, label: {
                        Text("Already have an account? Log in")

                    }).padding(.bottom)
                
                }
                
            }
            
            
            
            
        case true:
            FakeFormView(viewTitle: "Verify Email Address", spacer: 40) {
            

                VStack {
                    HStack {
                        Text("for: ").font(.subheadline)
                        Text(username).font(.title)
                    }
                    Spacer()
                   
                    FakeFormField(sectionText: "Confirmation Code", placeholderText: "012345", text: $code)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        handleConfirm(for: username, with: self.code)
//                        if(sessionManager.confirm(username: self.username, code: self.code)) {
//                            print("confirmed: " + username)
//                        }
//                        else {
//                            print("confirmation of \(username) failed")
//                        }
                        //  print("signing up: \(self.username)")
                    }
                    ){
                        Text("Confirm")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color("Element"))
                        .cornerRadius(30)
                            .scaleEffect(1.2)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            
        
        
        }
    
    }
    
    
    
//    ///came from https://docs.amplify.aws/lib/auth/signin/q/platform/ios#register-a-user
//    func handleSignUp(username: String, password: String, email: String) -> AnyCancellable {
//        let userAttributes = [AuthUserAttribute(.email, value: email)]
//        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
//        let sink = Amplify.Auth.signUp(username: username, password: password, options: options)
//            .resultPublisher
//            .sink {
//                if case let .failure(authError) = $0 {
//                    print("An error occurred while registering a user \(authError)")
//                }
//            }
//            receiveValue: { signUpResult in
//                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
//                    print("Delivery details: \(String(describing: deliveryDetails))")
//                } else {
//                    print("SignUp Complete")
//                }
//
//            }
//        return sink
//    }
    
    func handleSignUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    /// came from https://docs.amplify.aws/lib/auth/signin/q/platform/ios#register-a-user
//    func handleConfirm(for username: String, with confirmationCode: String) -> AnyCancellable {
//        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
//            .resultPublisher
//            .sink {
//                if case let .failure(authError) = $0 {
//                    print("An error occurred while confirming sign up \(authError)")
//                }
//            }
//            receiveValue: { _ in
//                print("Confirm signUp succeeded")
//            }
//    }
//
    func handleConfirm(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }

    
}


struct FlowSignUpAndConfrim_Previews: PreviewProvider {
    static var previews: some View {
            SignUpView()
        
    }
}
