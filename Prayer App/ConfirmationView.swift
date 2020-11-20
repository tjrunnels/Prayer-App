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
        VStack {
                    
            Text("Verify Email Address")
                .font(.largeTitle)
                .bold()
            Text("Username: \(username)")
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)

            TextField("Confirmation Code", text: $code)
                .padding()
                .background(Color.gray.opacity(0.1))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                                    
            Button(action: {
                sessionManager.confirm(username: self.username, code: self.code)
                print("signing up: \(self.username)")
            }
            ){
                Text("Confirm")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
                .scaleEffect(0.8)
            }

        }

    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "previewUsername")
    }
}
