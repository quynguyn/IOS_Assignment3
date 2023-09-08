//
//  Assignment3App.swift
//  Assignment3
//
//  Created by quy.nguyn on 08/09/2023.
//

import SwiftUI
import Firebase

@main
struct Assignment3App: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
