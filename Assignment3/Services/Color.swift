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

extension Color {
    init(hex:UInt, alpha: Double = 1){
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff)/255,
            green: Double((hex >> 08) & 0xff)/255,
            blue: Double((hex >> 00) & 0xff)/255,
            opacity: alpha
        )
    }
}

extension Color{
    static var BackgroundColor: Color {
        return Color("BackgroundColor")
    }
    
    static var ReverseBackgroundColor: Color {
        return Color("ReverseBackgroundColor")
    }
    
    static var SecondaryBackgroundColor: Color {
        return Color("SecondaryBackgroundColor")
    }
    
    static var AccentColor: Color {
        return Color("AccentColor")
    }
    
    static var PrimaryColor: Color {
        return Color("PrimaryColor")
    }
    
    static var TextColor: Color {
        return Color("TextColor")
    }
    
    static var SecondaryTextColor: Color {
        return Color("SecondaryTextColor")
    }
}

func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
    if let url = URL(string: urlString) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
}
