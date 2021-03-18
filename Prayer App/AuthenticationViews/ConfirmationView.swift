//
//  ConfirmationView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/19/20.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager: AuthSessionManager
    
    let username: String

    @State var code : String = ""

    
    var body: some View {
        
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
                    sessionManager.confirm(username: self.username, code: self.code)
                    print("signing up: \(self.username)")
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

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "supertom500")
    }
}
