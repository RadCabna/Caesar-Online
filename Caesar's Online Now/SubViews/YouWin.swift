//
//  YouWin.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 18.06.2025.
//

import SwiftUI

struct YouWin: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var bgOpacity: CGFloat = 0
    @AppStorage("yourLevelCount") var yourLevelCount = 0
    @AppStorage("enemyLevelCount") var enemyLevelCount = 0
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("sound") var sound = true
    @State private var levelsCountData = UserDefaults.standard.array(forKey: "levelsCountData") as? [Int] ?? [3,0,0,0,0,0]
    @Binding var youWin: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(bgOpacity)
            Image("winFrame")
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
                        coinCount += 100
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            yourLevelCount = 0
                            enemyLevelCount = 0
                            if levelsCountData[levelNumber] < 3 {
                                levelsCountData[levelNumber] = 0
                                UserDefaults.standard.setValue(levelsCountData, forKey: "levelsCountData")
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
                        coinCount += 100
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if levelsCountData[levelNumber] < 3 {
                                levelsCountData[levelNumber] += 1
                                UserDefaults.standard.setValue(levelsCountData, forKey: "levelsCountData")
                            }
                            if yourLevelCount < 2 {
                                yourLevelCount += 1
                                youWin.toggle()
                            } else {
                                yourLevelCount = 0
                                enemyLevelCount = 0
                                coordinator.navigate(to: .choseLevel)
                            }
                        }
                    }
            }
            .offset(y: screenWidth*0.15)
        }
        
        .onAppear {
            showViewAnimation()
            if sound {
                SoundManager.instance.playSound(sound: "bonusWinSound")
            }
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
    YouWin(youWin: .constant(true))
}
