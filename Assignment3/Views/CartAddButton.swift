//
//  CartButton.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartAddButton: View {
    var body: some View {
        Text("Add to Cart")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: 0xffd89c))
            .cornerRadius(10)
    }
}

struct CartAddButton_Previews: PreviewProvider {
    static var previews: some View {
        CartAddButton()
    }
}
