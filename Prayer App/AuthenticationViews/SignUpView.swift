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
    
    @State var isButtonActive = false


//    @ObservedObject private var userData: SessionData = .shared
    
    var body: some View {
        FakeFormView(viewTitle: "Sign Up", spacer: 40) {
        
//
//            Form {
//                CustomTextField_Section(placeholderText: "prayermaster500", text: $username, sectionTitle: "Username")
//                CustomTextField_Section(placeholderText: "pm500@gmail.com", text: $email, sectionTitle: "Email")
//                CustomTextField_Section(placeholderText: "PM500pa$$",       text: $password, sectionTitle: "password")
//            }
            
            FakeFormField(sectionText: "Username", placeholderText: "prayermaster500", text: $username, disableAutoCorrect: true)
                .padding(.bottom, 20)
            FakeFormField(sectionText: "Email", placeholderText: "pm500@gmail.com", text: $email, disableAutoCorrect: true)
                .padding(.bottom, 20)
            FakeFormField(sectionText: "password", placeholderText: "PM501pa$$", text: $password, disableAutoCorrect: true)
                .padding(.bottom, 20)

            
            
            Spacer()
                .frame(height:25)
                                    
            VStack {
                
                //TODO: ok so this whole button thing isn't working.  I need to encompas the signup and confirm in one parent view and then 
                NavigationLink(
                    destination: ConfirmationView(username: self.username),
                    isActive: $isButtonActive
                ) {
                    Button(action: {
                        if(sessionManager.signUp(username: self.username, email: self.email, password: self.password)) {
                          //  print("signup of \(username) successful, moving to confirmation")
                        }
                        else {
                           // print("signup of \(username) failed")
                        }
                        
                        print("signing up: \(self.username)")
                    }
                    ){
                        Text("Sign Up")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color("Element"))
                        .cornerRadius(30)
                            .scaleEffect(1.2)
                    }
                }
            
            
            
                Spacer()
                    

                
                Button(action: {
                    print("login pressed on signin screen")
                    
                }, label: {
                    Text("Already have an account? Log in")

                }).padding(.bottom)

            
            }
            

        }

    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
            SignUpView()
        
    }
}

struct FakeFormField: View {
    var sectionText: String
    var placeholderText: String
    @Binding var text: String
    var disableAutoCorrect = false
    
    var body: some View {
        VStack {
            HStack {
                Text(sectionText.uppercased())
                    .font(Font.custom("SF Pro Text", size: 13.0))
                    .foregroundColor(.gray)
                    .padding(.leading)
                Spacer()
            }
            CustomTextField(placeholderText: self.placeholderText, text: $text, disableAutoCorrect: disableAutoCorrect)
                .padding(.leading, 20)
                .frame( height: 50)
                .background(Color(.white))
                .cornerRadius(10)
                .padding([.leading, .trailing], 20)
        }
    }
}
