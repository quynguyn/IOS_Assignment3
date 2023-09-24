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

struct IngredientView: View {
    @Environment(\.colorScheme) var colorScheme
    var food: Food
    @EnvironmentObject var cartManager: CartManager
    @State private var foodImage: UIImage? = nil
    
    var body: some View {
        
        ScrollView() {
            
            ZStack(alignment: .bottom){
                if let uiImage = foodImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(20)
                } else {
                    Rectangle()  // Placeholder till image loads
                    .foregroundColor(.gray)
                    .frame(width: 400, height: 400)
                }
                
                Text(food.name)
                    .padding()
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .background(.white)
                    .cornerRadius(25)
                    .foregroundColor(Color(.black))
            }
            VStack(alignment: .leading, spacing: 16) {
                Text("Ingredients:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x85a389))
                    .padding(10)
                    //.background(colorScheme == .dark ?.white :.black)
                
                
                ForEach(food.ingredients ?? [], id: \.self) { ingredient in
                    HStack {
                        Text("❥ \(ingredient)")
                            .foregroundColor(colorScheme == .dark ?.white :.black)
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }
                
                Text("Recipe:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x85a389))
                    .padding(10)
                    //.background(colorScheme == .dark ?.white :.black)
                
                ForEach(food.recipe , id: \.self) { recipe in
                    Text("➜ \(recipe)")
                        .font(.body)
                        .padding(.leading, 10)
                }
            }
            .onAppear {
                loadImageFromURL(urlString: food.image) { image in
                    self.foodImage = image
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }
}
    
    
    struct IngredientView_Previews: PreviewProvider {
        static var previews: some View {
            IngredientView(food:burger).environmentObject(CartManager())
        }
    }
