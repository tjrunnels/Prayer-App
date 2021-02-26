//
//  Prayer_AppApp.swift
//  Prayer App
//
//  Created by tomrunnels on 11/13/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct Prayer_AppApp: App {
    
    @ObservedObject var authSessionManager = AuthSessionManager() //tomdo: change to StateObject?
    @ObservedObject var sessionData = SessionData()

    
    init() {
        configureAmplify()
        //ackend.shared.signOut()
        //authSessionManager.getCurrentAuthUser()
    }
    
    private func configureAmplify() {
      // MARK: - amplify
      // initialize amplify
      do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
        try Amplify.add(plugin: AWSS3StoragePlugin())
        try Amplify.configure()
        print("Initialized Amplify");
      } catch {
        print("Could not initialize Amplify: \(error)")
      }
    }
    
    
    var body: some Scene {
        WindowGroup {
  
            switch (sessionData.currentUser != nil) {
                case true:
                    MainTabView(user: sessionData.currentUser!)
                        .environmentObject(authSessionManager)
                default:
                    LoginView { user in
                        sessionData.currentUser = user
                    }
                    
            }
            
            
//            switch authSessionManager.authState {
//            case .login:
//                LoginView()
//                    .environmentObject(authSessionManager)
//            case .signUp:
//                SignUpView()
//                    .environmentObject(authSessionManager)
//            case .confirmCode(let username):
//                ConfirmationView(username: username)
//                    .environmentObject(authSessionManager)
//            case .session(let user):
//                MainTabView(user: user)
//                    .environmentObject(authSessionManager)
//            }
            
            
            
            
            
        }
    }
}
