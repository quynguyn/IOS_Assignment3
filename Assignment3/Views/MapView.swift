//
//  MapView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    var location: CLLocationCoordinate2D
}

struct MapView: View {
    @ObservedObject var mapStore : MapStore
    
    var body: some View {
        Map(coordinateRegion: $mapStore.region,
            annotationItems: mapStore.annotationItems) { marker in
            MapMarker(coordinate: marker.coordinate, tint: .red)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var mapStore = MapStore()
    static var previews: some View {
        MapView(mapStore: mapStore)
    }
}

//10.729303, 106.696129
