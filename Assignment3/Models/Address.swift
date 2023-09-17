//
//  Address.swift
//  Assignment3
//
//  Created by Trung Nguyen on 16/09/2023.
//

import Foundation

struct Address : Identifiable {
    let id = UUID()
    var deliveryAddress: String?
    var contactName: String?
    var contactPhone: String?
}
