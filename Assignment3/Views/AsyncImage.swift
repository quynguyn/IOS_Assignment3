//
//  AsyncImage.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 14/09/2023.
//

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
