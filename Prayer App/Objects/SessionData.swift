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
    static let shared = SessionData()

    @Published var Prayers : [Prayer] = []
    @Published var isSignedIn : Bool = false
    @Published var currentError : String = ""
}
