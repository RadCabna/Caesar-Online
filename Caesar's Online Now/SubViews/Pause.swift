//
//  Pause.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 19.06.2025.
//

import SwiftUI

struct Pause: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("yourLevelCount") var yourLevelCount = 0
    @AppStorage("enemyLevelCount") var enemyLevelCount = 0
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("coinCount") var coinCount = 0
    @State private var levelsCountData = UserDefaults.standard.array(forKey: "levelsCountData") as? [Int] ?? [3,0,0,0,0,0]
    @State private var bgOpacity: CGFloat = 0
    @Binding var showPause: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(bgOpacity)
            Image("pauseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.35)
            Text("PAUSE")
                .font(Font.custom("CrushYourEnemies", size: screenWidth*0.04))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2)
                .shadow(color: .black, radius: 2)
            HStack(spacing: screenWidth*0.15) {
                Image("homeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        hideViewAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            enemyLevelCount = 0
                            yourLevelCount = 0
                            if  levelsCountData[levelNumber-1] < 3 {
                                levelsCountData[levelNumber-1] = 0
                                UserDefaults.standard.set(levelsCountData, forKey: "levelsCountData")
                            }
                            coordinator.navigate(to: .mainMenu)
                        }
                    }
                Image("nextButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        hideViewAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showPause.toggle()
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
    Pause(showPause: .constant(true))
}
