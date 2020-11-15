//
//  AppDelegate.swift
//  Prayer App
//
//  Created by tomrunnels on 11/13/20.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // initialize Amplify
            let _ = Backend.initialize()
        
        return true
    }
}
