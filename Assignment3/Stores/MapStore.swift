//
//  MapStore.swift
//  Assignment3
//
//  Created by Trung Nguyen on 16/09/2023.
//

import Foundation
import MapKit

class MapStore : ObservableObject {
    
    @Published var region = MKCoordinateRegion()
    @Published var annotationItems: [AnnotationItem] = []
    
    func getPlace(from address: Address) {
        let request = MKLocalSearch.Request()
        let title = address.title
        
        request.naturalLanguageQuery = title
        
        Task {
            let response = try await MKLocalSearch(request: request).start()
            await MainActor.run {
                self.annotationItems = response.mapItems.map {
                    AnnotationItem(
                        latitude: $0.placemark.coordinate.latitude,
                        longitude: $0.placemark.coordinate.longitude
                    )
                }
                
                self.region = response.boundingRegion
                print("region \(self.region.center)")
            }
        }
    }
}
