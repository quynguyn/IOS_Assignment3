//
//  Utils.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

import Foundation
import FirebaseFirestore

struct DateUtils {
    static func getDateFromString(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: str)
    }

}

struct FirestoreUtils {
    static func fromFirebaseDocument<T : Decodable>(documentSnapshot: DocumentSnapshot) -> T? {
        do {
            let jsonObject = documentSnapshot.data()
            guard var jsonObject else {
                return nil
            }
            jsonObject.updateValue(documentSnapshot.documentID, forKey: "id")
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
            return try JSONDecoder().decode(T.self, from: jsonData);
            
        } catch {
            print("error \(error.localizedDescription)")
            return nil
        }
    }
}
