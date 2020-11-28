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
import AmplifyPlugins
import SwiftUI


class AWS_Backend : ObservableObject {
    static let shared = AWS_Backend()
    static func initialize() -> AWS_Backend {
        return .shared
    }
    
    @ObservedObject var sessionManager = AuthSessionManager()
    
    private init() {
        
    }
    

    // change our internal state, this triggers an UI update on the main thread
    func updateSessionData(withSignInStatus status : Bool) {
        DispatchQueue.main.async() {
            let sessionData : SessionData = .shared
            sessionData.isSignedIn = status
            
            // when user is signed in, query the database, otherwise empty our model
            if status {
                self.queryPrayers()
            } else {
                sessionData.Prayers = []
            }
        }
    }
    
    func updateSessionData(withError error : String) {
        DispatchQueue.main.async() {
            let sessionData : SessionData = .shared
            sessionData.currentError = error
            
        }
    }

    
    
    
    // MARK: - API Access

       func queryPrayers() {
        _ = Amplify.API.query(request: .list(PrayerData.self)) { event in
               switch event {
               case .success(let result):
                   switch result {
                   case .success(let PrayersData):
                       print("Successfully retrieved list of Prayers")

                       // convert an array of PrayerData to an array of Prayer class instances
                       for n in PrayersData {
                           let prayer = Prayer.init(from: n)
                            
                           DispatchQueue.main.async() {
                               SessionData.shared.Prayers.append(prayer)
                           }
                       }

                   case .failure(let error):
                       print("Can not retrieve result : error  \(error.errorDescription)")
                   }
               case .failure(let error):
                   print("Can not retrieve Prayers : error \(error)")
               }
           }
       }

       func createPrayer(Prayer: Prayer) {

           // use Prayer.data to access the PrayerData instance
           _ = Amplify.API.mutate(request: .create(Prayer.data)) { event in
               switch event {
               case .success(let result):
                   switch result {
                   case .success(let data):
                       print("Successfully created Prayer: \(data)")
                   case .failure(let error):
                       print("Got failed result with \(error.errorDescription)")
                   }
               case .failure(let error):
                   print("Got failed event with error \(error)")
               }
           }
       }

       func deletePrayer(Prayer: Prayer) {

           // use Prayer.data to access the PrayerData instance
           _ = Amplify.API.mutate(request: .delete(Prayer.data)) { event in
               switch event {
               case .success(let result):
                   switch result {
                   case .success(let data):
                       print("Successfully deleted Prayer: \(data)")
                   case .failure(let error):
                       print("Got failed result with \(error.errorDescription)")
                   }
               case .failure(let error):
                   print("Got failed event with error \(error)")
               }
           }
       }
    
    
    
    // MARK: - Image Storage

    func storeImage(name: String, image: Data) {

    //        let options = StorageUploadDataRequest.Options(accessLevel: .private)
        let _ = Amplify.Storage.uploadData(key: name, data: image,// options: options,
            progressListener: { progress in
                // optionlly update a progress bar here
            }, resultListener: { event in
                switch event {
                case .success(let data):
                    print("Image upload completed: \(data)")
                case .failure(let storageError):
                    print("Image upload failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        })
    }

    func retrieveImage(name: String, completed: @escaping (Data) -> Void) {
        let _ = Amplify.Storage.downloadData(key: name,
            progressListener: { progress in
                // in case you want to monitor progress
            }, resultListener: { (event) in
                switch event {
                case let .success(data):
                    print("Image \(name) loaded")
                    completed(data)
                case let .failure(storageError):
                    print("Can not download image: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
            }
        )
    }

    func deleteImage(name: String) {
        let _ = Amplify.Storage.remove(key: name,
            resultListener: { (event) in
                switch event {
                case let .success(data):
                    print("Image \(data) deleted")
                case let .failure(storageError):
                    print("Can not delete image: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
            }
        )
    }
    
    
    
    
} //end of class
