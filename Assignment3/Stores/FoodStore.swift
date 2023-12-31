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

import Foundation
import FirebaseFirestore

private let FOOD_PER_PAGE = 5

@MainActor
class FoodStore : ObservableObject {
    @Published var foodList: [Food] = []
    @Published var isGettingFood = false
    
    private var db = Firestore.firestore()
    private var filteringCategory = "All"
    private var filteringName: String?
    
    init() {
        self.findFoodList()
    }
    
    private var currentPage = 1
    
    private func findFoodList() {
        isGettingFood = true
        Task.init(priority: .high) {
            do {
                var query = self.db.collection(FOODS_COLLECTION_PATH)
                    .limit(to: self.currentPage * FOOD_PER_PAGE)
                
                if (self.filteringCategory != "All") {
                    query = query.whereField("category", in: [self.filteringCategory])
                }
                
                let querySnapshot = try await query.getDocuments()
                self.foodList = querySnapshot.documents.compactMap(FoodService.fromFirebaseDocument)
                isGettingFood = false
            } catch {
                isGettingFood = false
            }
        }
    }
        
    
    
    func nextPage() {
        currentPage += 1
        findFoodList()
    }
    
    func resetPage() {
        currentPage = 1;
    }
    
    func filterByName(name: String) {
        self.filteringName = name
    }
    
    func filterByCategory(category: String) {
        if (category == self.filteringCategory){
            return
        }
        
        self.resetPage()
        self.filteringCategory = category
        self.findFoodList()
    }
    
    var filteredList: [Food] {
        guard let searchTerm = self.filteringName, !searchTerm.isEmpty else {
            return self.foodList
        }
        
        return self.foodList.filter {
            food in
            food.name.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    var top5RatedFoods: [Food] {
        let sortedFoods = foodList.sorted(by: { ($0.rate ?? 0) > ($1.rate ?? 0) })
        return Array(sortedFoods.prefix(5))
    }
    
}
