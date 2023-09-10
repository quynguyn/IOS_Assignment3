//
//  EditableText.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI

struct EditableText: View {
    @Binding var text: String
    @State private var temporaryText: String
    @FocusState private var isFocused: Bool
    
    init(text: Binding<String>) {
        self._text = text
        self.temporaryText = text.wrappedValue
    }
    
    var body: some View {
        TextField("", text: $temporaryText, onCommit: { text = temporaryText })
            .font(.system(size: 16, design: .rounded))
            .fontWeight(.regular)
            .focused($isFocused, equals: true)
            .onTapGesture { isFocused = true }
    }
}

struct EditableText_Previews: PreviewProvider {
    @State static private var text: String = ""
    static var previews: some View {
        EditableText(text: $text)
    }
}
