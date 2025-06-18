//
//  YouLose.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 18.06.2025.
//

import SwiftUI

struct YouLose: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var bgOpacity: CGFloat = 0
    @AppStorage("yourLevelCount") var yourLevelCount = 0
    @AppStorage("enemyLevelCount") var enemyLevelCount = 0
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("coinCount") var coinCount = 0
    @State private var levelsCountData = UserDefaults.standard.array(forKey: "levelsCountData") as? [Int] ?? [3,0,0,0,0,0]
    @Binding var youLose: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(bgOpacity)
            Image("loseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.35)
            HStack(spacing: screenWidth*0.15) {
                Image("homeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        hideViewAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .mainMenu)
                        }
                    }
                Image("restartButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        hideViewAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            youLose.toggle()
                        }
                    }
            }
            .offset(y: screenWidth*0.15)
        }
        
        .onAppear {
            showViewAnimation()
        }
    }
    
    func showViewAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            bgOpacity = 0.5
        }
    }
    
    func hideViewAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            bgOpacity = 0
        }
    }
    
}

#Preview {
    YouLose(youLose: .constant(true))
}
