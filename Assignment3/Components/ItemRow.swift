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

struct ItemRow: View {
    @EnvironmentObject var cartManager: CartManager
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @State private var foodImage: UIImage? = nil
    var item: Food
    
    var body: some View {
        VStack{
            HStack {
                
                if let uiImage = foodImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(1, contentMode: .fill)
                        .cornerRadius(20)
                } else {
                    Rectangle()  // Placeholder till image loads
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 100)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.name)
                        .bold()
                    Text("$\(item.price, specifier: "%.2f")")
                }
                Spacer()
                Image(systemName: "trash")
                    .foregroundColor(Color("#85A389"))
                    .onTapGesture {
                        cartManager.deleteFromCart(item: item)
                    }
                
            }
            .onAppear {
                loadImageFromURL(urlString: item.thumbnail.first ?? "") { image in
                    self.foodImage = image
                }
            }
            .shadow(radius: 10)
            Rectangle()
                .frame(height: 2) // Adjust the height to control the border thickness
                .foregroundColor(Color(hex: 0xffd89c))
        }
        
        
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: FoodList[0])
            .environmentObject(CartManager())
    }
}
