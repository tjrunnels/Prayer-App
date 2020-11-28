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
    
    @ObservedObject var sessionManager = AuthSessionManager()
    
    init() {
        configureAmplify()
        //ackend.shared.signOut()
        sessionManager.getCurrentAuthUser()
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
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)
            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)
            case .session(let user):
                MainTabView(user: user)
                    .environmentObject(sessionManager)
            }
        }
    }
}
