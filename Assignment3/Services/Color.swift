//
//  Color.swift
//  Assignment3
//
//  Created by quy.nguyn on 08/09/2023.
//

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
