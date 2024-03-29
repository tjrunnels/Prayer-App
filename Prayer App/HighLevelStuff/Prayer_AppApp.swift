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
        sessionData.currentAuthUser = Amplify.Auth.getCurrentUser()
    }
    
    private func configureAmplify() {
      // MARK: - amplify
      // initialize amplify
      do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
        try Amplify.add(plugin: AWSS3StoragePlugin())
        
        let datastorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        try Amplify.add(plugin: datastorePlugin);
        
        try Amplify.configure()
        print("Initialized Amplify");
      } catch {
        print("Could not initialize Amplify: \(error)")
      }
    }
    
    
    var body: some Scene {
        WindowGroup {
  
            //don't start the session without an AuthUser (1)
            switch (sessionData.currentAuthUser != nil) {
                case true:
                    MainTabView(authUser: sessionData.currentAuthUser!)
                        .environmentObject(authSessionManager)
                default:
                    LoginView { user in
                        sessionData.currentAuthUser = user
                    }
                    
            }
            
            
        }
    }
}
