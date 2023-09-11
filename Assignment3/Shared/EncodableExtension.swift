//
//  EncodableExtension.swift
//  Assignment3
//
//  Created by Trung Nguyen on 10/09/2023.
//

import Foundation

// https://stackoverflow.com/questions/46597624/can-swift-convert-a-class-struct-data-into-dictionary
struct JSON {
    static let encoder = JSONEncoder()
}

// Useful to convert a struct to a dict, which is then uploaded to Firestore
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
