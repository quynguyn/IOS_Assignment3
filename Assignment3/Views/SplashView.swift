//
//  SplashView.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var size: Double
    @Binding var opacity: Double
    
    var body: some View {
        VStack{
            Spacer()
            Image("icon")
                .resizable()
                .scaledToFit()
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            Spacer()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            SplashView(
                size: .constant(0.8), opacity: .constant(0.5))
        }
    }
}
