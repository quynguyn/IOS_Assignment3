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
import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    let iconName: String
    @Binding var text: String
    

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color(hex: 0xa2cdb0))
                .frame(width: 30, height: 30)
                TextField(placeholder, text: $text)
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: 0xf1c27b), lineWidth: 3))
    }
}

struct CustomSecureField: View {
    let placeholder: String
    let iconName: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color(hex: 0xa2cdb0))
                .frame(width: 30, height: 30)
                SecureField(placeholder, text: $text)
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: 0xf1c27b), lineWidth: 3))
    }
}

