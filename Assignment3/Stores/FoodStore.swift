//
//  FoodStore.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 13/09/2023.
//

import Foundation
import FirebaseFirestore

private let FOOD_PER_PAGE = 5

@MainActor
class FoodStore : ObservableObject {
    @Published var foodList: [Food] = []
    @Published var isGettingFood = false
    
    private var db = Firestore.firestore()
    private var filteringCategory = "All"
    
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
        print("next Page")
        findFoodList()
    }
    
    func resetPage() {
        currentPage = 1;
    }
    
    func filterByCategory(category: String) {
        self.resetPage()
        self.filteringCategory = category
        self.findFoodList()
    }
    
    var top5RatedFoods: [Food] {
        let sortedFoods = foodList.sorted(by: { ($0.rate ?? 0) > ($1.rate ?? 0) })
        return Array(sortedFoods.prefix(5))
    }
    
}
