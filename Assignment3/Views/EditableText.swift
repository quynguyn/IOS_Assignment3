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
