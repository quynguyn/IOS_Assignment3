//
//  AnnotationItem.swift
//  Assignment3
//
//  Created by Trung Nguyen on 16/09/2023.
//

import Foundation
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
