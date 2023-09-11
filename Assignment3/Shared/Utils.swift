//
//  Utils.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

import Foundation

struct DateUtils {
    static func getDateFromString(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: str)
    }

}
