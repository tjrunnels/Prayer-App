//
//  AWSModels_Extensions.swift
//  Prayer App
//
//  Created by tomrunnels on 3/15/21.
//

import Foundation
import Amplify

//MARK:- Hashables and Identifieables


extension Prayer: Hashable, Identifiable {
    public static func == (lhs: Prayer, rhs: Prayer) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

extension PrayerGroup: Hashable, Identifiable {
    public static func == (lhs: PrayerGroup, rhs: PrayerGroup) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}


extension PrayerGroupUser: Hashable, Identifiable {
    public static func == (lhs: PrayerGroupUser, rhs: PrayerGroupUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}



extension User: Hashable, Identifiable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}




//MARK:- Other
extension List {
    func toArray<T>(ofType: T.Type) -> [T] {
            var array = [T]()
            for i in 0 ..< count {
                if let result = self[i] as? T {
                    array.append(result)
                }
            }

            return array
        }
}
