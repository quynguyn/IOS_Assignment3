/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author:
 Nguyen Quoc Hoang Trung - s3818328
 Vu Nguyet Minh - s3878520
 Pham Duy Anh - s3802674
 Nguyen Minh Hien - s3877996
 Nguyen Van Quy - s3878636
 Created  date: 8/9/2023
 Last modified: 23/9/2023
  Acknowledgement:
    “Full-text search | firestore | Firebase,” Google, https://firebase.google.com/docs/firestore/solutions/search?provider=algolia (accessed Sep. 21, 2023).
*/

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
