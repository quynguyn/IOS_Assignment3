//
//  EnvironmentWrapper.swift
//  Assignment3
//
//  Created by Trung Nguyen on 09/09/2023.
//

import SwiftUI

struct EnvironmentWrapper<Content: View>: View {
    @ViewBuilder var content: Content
    
    // Global objects
    @StateObject private var authStore = AuthStore()
    @StateObject private var cartManager = CartManager()
    //@StateObject private var foodStore = FoodStore()
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .environmentObject(authStore)
        .environmentObject(cartManager)
    }
}

struct EnvironmentWrapper_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            Text("EnvironmentWrapperView")
        }
    }
}
