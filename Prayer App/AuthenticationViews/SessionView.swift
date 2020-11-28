//
//  SessionView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/19/20.
//

import SwiftUI
import Amplify

struct SessionView: View {
    
    @EnvironmentObject var sessionManager : AuthSessionManager
    
    let user: AuthUser
    
    init(user: AuthUser) {
        self.user = user
    }
    
    var body: some View {
        Text("Hello, and welcome to the simulation, \(user.username)!")
    }
}

struct SessionView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummyUser"
    }
    static var previews: some View {
        SessionView(user: DummyUser())
    }
}
