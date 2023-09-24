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
