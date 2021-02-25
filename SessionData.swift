//
//  SessionData.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import Foundation
import Amplify

// singleton object to store session data
class SessionData : ObservableObject {
    
    private init() {}
    static var shared = SessionData()

    @Published var prayers : [Prayer] = []
    @Published var isSignedIn : Bool = false
    @Published var currentError : String = ""
}
