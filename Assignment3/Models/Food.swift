//
//  Food.swift
//  Assignment3
//
//  Created by Trung Nguyen on 10/09/2023.
//

import Foundation
import FirebaseFirestore

struct CreateFood : Hashable, Codable {
    let name: String
    let image: String
    let thumbnail: String
    let category: String
    let price: Double
    let description: String
    
    let calories: Int?
    let rate: Double?
    let comment: String?
    let ingredients: [String]?
}

struct UpdateFood : Hashable, Codable {
    var name: String? = nil
    var image: String? = nil
    var thumbnail: String? = nil
    var category: String? = nil
    var price: Double? = nil
    var description: String? = nil
    
    var calories: Int? = nil
    var rate: Double? = nil
    var comment: String? = nil
    var ingredients: [String]? = nil
    
    init(name: String? = nil,
         image: String? = nil,
         thumbnail: String? = nil,
         category: String? = nil,
         price: Double? = nil,
         description: String? = nil,
         calories: Int? = nil,
         rate: Double? = nil,
         comment: String? = nil,
         ingredients: [String]? = nil) {
        self.name = name
        self.image = image
        self.thumbnail = thumbnail
        self.category = category
        self.price = price
        self.description = description
        self.calories = calories
        self.rate = rate
        self.comment = comment
        self.ingredients = ingredients
    }
}

struct Food : Identifiable, Hashable, Codable {
    static let sampleData = Food(
        id: "123",
        name: "Margherita Pizza",
        image: "pizza_image", // Replace with your image file name or URL
        thumbnail: "pizza_thumbnail",
        category: "Italian",
        price: 12.99,
        description: "Classic margherita pizza with fresh tomatoes and basil.",
        calories: nil,
        rate: nil,
        comment: nil,
        ingredients: nil
    )
    
    let id: String
    let name: String
    let image: String
    let thumbnail: String
    let category: String
    let price: Double
    let description: String
    
    let calories: Int?
    let rate: Double?
    let comment: String?
    let ingredients: [String]?
}

var FoodList = [Food(id: "1", name: "Burger", image: "burger", thumbnail: "burger", category: "American", price: 12.99, description: "Burger!", calories: nil, rate: nil, comment: nil, ingredients: nil),
                Food(id: "2", name: "Pizza", image: "pizza", thumbnail: "pizza", category: "Italian", price: 10.99, description: "Pizza!", calories: nil, rate: nil, comment: nil, ingredients: nil),
                Food(id: "3", name: "French fries", image: "frenchfries", thumbnail: "frenchfries", category: "American", price: 2.99, description: "French fries!", calories: nil, rate: nil, comment: nil, ingredients: nil),
                Food(id: "4", name: "Fried chicken", image: "friedchicken", thumbnail: "friedchicken", category: "American", price: 11.99, description: "Fried chicken!", calories: nil, rate: nil, comment: nil, ingredients: nil),
                Food(id: "5", name: "Sushi", image: "sushi", thumbnail: "sushi", category: "Japanese", price: 15.99, description: "Sushi!", calories: nil, rate: nil, comment: nil, ingredients: nil)]
