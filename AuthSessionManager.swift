//
//  AuthSessionManager.swift
//  Prayer App
//
//  Created by tomrunnels on 11/18/20.
//

import Foundation
import Amplify

enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}

final class AuthSessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    @Published var authUsername = String()
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            print("Session with user: " + user.username)
            authUsername = user.username
            authState = .session(user: user)
        } else {
            authState = .login
        }
    }
    
    func showSignUP() {
        authState = .signUp
    }
    
    func showLogin() {
        authState = .login
    }
    
    
    func login(username: String, password: String) {
        _ = Amplify.Auth.signIn(
            username: username,
            password: password
        ) { [weak self] result in
            print("Auth.signIn results: \(result)")
            switch  result {
            case .success(let signInResult):
                //redundant... not sure why:  AWS_Backend.shared.updateSessionData(withSignInStatus: true)
                print(signInResult)
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self?.getCurrentAuthUser()
                    }
                }
            case .failure(let error):
                print("Login error: ", error)
            }
        }
    }
    
    func signOut() {
        _ = Amplify.Auth.signOut()
        { [weak self] result in
            
            switch  result {
            case .success:
               // AWS_Backend.shared.updateSessionData(withSignInStatus: false, sessionDataPrayers: nil)
                DispatchQueue.main.async {
                    self?.getCurrentAuthUser()
                }
                
            case .failure(let error):
                print("Sign out error: ", error)
            }
        }
    }
    
    
    func signUp(username: String, email: String, password: String) -> Bool {
        
        var tmpBool: Bool = false
        
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
       
        Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options)
        { [weak self] result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    
                    DispatchQueue.main.async {
                        self?.authState = .confirmCode(username: username)
                    }
                    tmpBool = (true);
                } else {
                    print("SignUp Complete")
                    tmpBool = (true);
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                tmpBool = false
                
            }
        }
        return tmpBool
    }
    
    func confirm(username: String, code: String) -> Bool {
        var tmpBool: Bool = false
        
        _ = Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) { [weak self] result in
            
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.showLogin()
                    }
                    tmpBool = true
                }
            case .failure(let error):
                print("failed to confirm code:", error)
            }
        }
    return tmpBool
    }
    
    
}
