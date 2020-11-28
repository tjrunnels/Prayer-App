//
//  ContentView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/13/20.
//  Copied from https://aws.amazon.com/getting-started/hands-on/build-ios-app-amplify/module-one/
//
//

import SwiftUI
import Amplify



// this is the main view of our app,
// it is made of a Table with one line per Prayer
struct ContentView: View {
    
    @EnvironmentObject var sessionManager : AuthSessionManager
    
    // add at the begining of ContentView class
    @State var showCreatePrayer = false

   
    let user: AuthUser
    
    init(user: AuthUser) {
        AWS_Backend.shared.updateSessionData(withSignInStatus: true)
        self.user = user
    }

    
    @ObservedObject private var sessionData: SessionData = .shared

    // MARK: - begin of main body
    var body: some View {
        
        Text("...you're not supposed to be here! (this is ContentView)")
    
        
    }
}



//MARK: - Preview
// this is use to preview the UI in Xcode
struct ContentView_Previews: PreviewProvider {
    
    private struct leDummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummyUser"
   }
    
    static var previews: some View {
        
        let _ = prepareTestData()
        return ContentView(user: leDummyUser())
    }
}

// this is a test data set to preview the UI in Xcode
func prepareTestData() -> SessionData {
    let sessionData = SessionData.shared
    sessionData.isSignedIn = false
    let desc = "this is a very long description that should fit on multiiple lines.\nit even has a line break\nor two."

    let n1 = Prayer(id: "01", name: "Hello world", description: desc, image: "mic")
    let n2 = Prayer(id: "02", name: "A new Prayer", description: desc, image: "phone")

    n1.image = Image(systemName: n1.imageName!)
    n2.image = Image(systemName: n2.imageName!)

    sessionData.Prayers = [ n1, n2 ]

    return sessionData
}

