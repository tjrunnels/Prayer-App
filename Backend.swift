//
//  Backend.swift
//  Prayer App
//
//  Created by tomrunnels on 11/13/20.
//  Copied from https://aws.amazon.com/getting-started/hands-on/build-ios-app-amplify/module-two/
//
//

import UIKit
import Amplify

class Backend {
    static let shared = Backend()
    static func initialize() -> Backend {
        return .shared
    }
    private init() {
      // initialize amplify
      do {
        try Amplify.configure()
        print("Initialized Amplify");
      } catch {
        print("Could not initialize Amplify: \(error)")
      }
    }
}
