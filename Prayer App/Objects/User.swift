//
//  User.swift
//  Prayer App
//
//  Created by tomrunnels on 2/17/21.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: String
    var username: String
    var name: String
    var Country: String
    var State: String
    var isPlus: Bool
    var isDonor: Bool
    var iconName: String
}
