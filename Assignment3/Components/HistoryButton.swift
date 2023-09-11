//
//  HistoryButton.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct HistoryButton: View {
    var body: some View {
        Text("History")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: 0xffd89c))
            .cornerRadius(10)
    }
}

struct HistoryButton_Previews: PreviewProvider {
    static var previews: some View {
        HistoryButton()
    }
}
