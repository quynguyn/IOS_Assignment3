//
//  Food.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

import Foundation

struct Food {
    let name: String
    let image: String // You can replace this with URL if you are using remote images
    let price: Double
    let description: String
    let category: String

    // You can also include additional properties and methods as needed
}

let pizza = Food(name: "Margherita Pizza",
                 image: "pizza_image", // Replace with your image file name or URL
                 price: 12.99,
                 description: "Classic margherita pizza with fresh tomatoes and basil.",
                 category: "Italian")
