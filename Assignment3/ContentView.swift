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

struct ContentView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @EnvironmentObject private var authStore : AuthStore
    @StateObject var mainFlowController = MainFlowController()
    var body: some View {
        if isActive && !authStore.isLoadingAuthState {
            if authStore.user == nil {
                LogInView()
            }
            else {
                HomeView()
                    .environmentObject(mainFlowController)
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
