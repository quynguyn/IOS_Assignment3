/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author:
 Nguyen Quoc Hoang Trung - s3818328
 Vu Nguyet Minh - s3878520
 Pham Duy Anh - s3802674
 Nguyen Minh Hien - s3877996
 Nguyen Van Quy - s3878636
 Created  date: 8/9/2023
 Last modified: 23/9/2023
  Acknowledgement:
    “Full-text search | firestore | Firebase,” Google, https://firebase.google.com/docs/firestore/solutions/search?provider=algolia (accessed Sep. 21, 2023).
*/

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

