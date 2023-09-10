//
//  CustomSetUp.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

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

