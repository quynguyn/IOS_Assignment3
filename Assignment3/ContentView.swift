//
//  ContentView.swift
//  Assignment3
//
//  Created by quy.nguyn on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @EnvironmentObject private var authStore : AuthStore
    
    var body: some View {
        if isActive {
            if authStore.user == nil {
                LogInView()
            }
            else {
                HomeView()
            }
        }
        else {
            SplashView(size: $size, opacity: $opacity).onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            ContentView()
        }
    }
}
