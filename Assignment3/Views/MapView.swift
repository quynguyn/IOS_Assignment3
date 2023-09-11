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
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [Marker(location: coordinate)]) { marker in
            MapMarker(coordinate: marker.location, tint: .red)
        }
        .onAppear() {
                setRegion(coordinate)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 10.729303, longitude: 106.696129))
    }
}

//10.729303, 106.696129
