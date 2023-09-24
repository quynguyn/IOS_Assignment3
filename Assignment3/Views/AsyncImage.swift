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

struct AsyncImage: View {
    @State private var uiImage: UIImage? = nil
    let placeholder: Image
    let url: URL
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
        } else {
            placeholder
                .onAppear(perform: fetchImage)
        }
    }
    
    func fetchImage() {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = image
                }
            }
        }
        .resume()
    }
}
