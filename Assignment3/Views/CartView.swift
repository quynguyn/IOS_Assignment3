//
//  CartView.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        ScrollView {
            Text("Your cart is empty!")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
