//
//  AppDelegate.swift
//  Prayer App
//
//  Created by tomrunnels on 11/13/20.
//
//
//import Foundation
//import UIKit
//import Amplify
//import AmplifyPlugins
//import AWSMobileClient
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        // initialize Amplify
//            let _ = Backend.initialize()
//
//        initializeAWSMobileClient()
//
//        return true
//    }
//
//    func initializeAWSMobileClient(){
//        AWSMobileClient.default().initialize { (userState, error) in
//            if let error = error {
//                print("Error initializing AWSMobileClient: \(error.localizedDescription)")
//            } else if let userState = userState {
//                print("AWSMobileClient initialized. Current UserState: \(userState.rawValue)")
//            }
//        }
//     }
//}
