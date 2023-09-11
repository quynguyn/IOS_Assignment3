//
//  CartButton.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartButton: View {
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Image(systemName: "cart")
                .padding(.top, 5)
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton()
    }
}
