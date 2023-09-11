//
//  AppUser.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

import Foundation

// FirebaseAuth already declares User struct, use AppUser to avoid name clash.
struct AppUser : Codable {
    let uid: String
    let email: String
    
    let displayName: String?
    let address: String?
    let phone: String?
}

struct UpdateAppUser : Codable {
    var displayName: String? = nil
    var address: String? = nil
    var phone: String? = nil
    
    init(displayName: String? = nil, address: String? = nil, phone: String? = nil) {
        self.displayName = displayName
        self.address = address
        self.phone = phone
    }
}

struct CreateAppUser : Codable {
    let uid: String
    let email: String
    
    let displayName: String?
    let address: String?
    let phone: String?
}

