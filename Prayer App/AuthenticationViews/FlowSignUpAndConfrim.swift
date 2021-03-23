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
    
    @Binding var showThisSheet : Bool
    
    @State var username : String    = ""
    @State var email : String    = ""
    @State var password : String    = ""
    @State var code : String    = ""
    
    @State var isConfirmView = false
    @State var feedback: String = ""


//    @ObservedObject private var userData: SessionData = .shared
    
    var body: some View {
        
        switch (isConfirmView) {
        
        //if confirm is not ready, show signup
        case false:
            FakeFormView(viewTitle: "Sign Up", spacer: 40) {
            
                Text(feedback).font(.caption).foregroundColor(.red)

 
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
                            handleSignUp(username: self.username, password: self.password, email: self.email, returnBool: $isConfirmView, feedback: $feedback)
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
            
                Text(feedback).font(.caption).foregroundColor(.red)


                VStack {
                    HStack {
                        Text("for: ").font(.subheadline)
                        Text(username).font(.title)
                    }
                    Spacer()
                   
                    FakeFormField(sectionText: "Confirmation Code", placeholderText: "012345", text: $code)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        handleConfirm(for: username, with: self.code, confirmFailed: $showThisSheet, feedback: $feedback)
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

    
    func handleSignUp(username: String, password: String, email: String, returnBool: Binding<Bool>, feedback: Binding<String>) {
        
        
        //TODO: email addresses are not totally verified by AWS.  YOu can do it without a period
        
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    returnBool.wrappedValue = true
                    feedback.wrappedValue = ""
                } else {
                    print("SignUp Complete")
                    returnBool.wrappedValue = true
                    feedback.wrappedValue = ""
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                returnBool.wrappedValue = false
                feedback.wrappedValue = "\(error)"
            }
        }
    }
    
    /// came from https://docs.amplify.aws/lib/auth/signin/q/platform/ios#register-a-user

    func handleConfirm(for username: String, with confirmationCode: String, confirmFailed: Binding<Bool>, feedback: Binding<String>) {
        
        
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                print(result)
                //TODO: Create new PrayerAppAPI User on AuthUser creation

                confirmFailed.wrappedValue = false
                feedback.wrappedValue = ""
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
                confirmFailed.wrappedValue = true
                feedback.wrappedValue = "\(error)"
            }
        }
        

        
    }
    
//    func loadUserFromAuthID (userIDFromAuth: String) {
//        Amplify.DataStore.query(
//                User.self,
//                where: User.keys.id == userIDFromAuth
//            ) { result in
//            do {
//                let thisUser = try result.get()
//
//                print("User has been found:::\(1)")
//            } catch {
//                print(error)
//            }
//        }
//    }

    
}


struct FlowSignUpAndConfrim_Previews: PreviewProvider {
    static var previews: some View {
            SignUpView()
        
    }
}
