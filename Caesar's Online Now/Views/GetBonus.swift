//
//  GetBonus.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 19.06.2025.
//

import SwiftUI

struct GetBonus: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("sound") var sound = true
    @State private var bgOpacity: CGFloat = 0
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(bgOpacity)
            Image("winBonusFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.35)
            Image("getButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.15)
                .offset(y: screenWidth*0.15)
                .onTapGesture {
                    hideViewAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        coinCount += 50
                        coordinator.navigate(to: .mainMenu)
                    }
                }
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
    GetBonus()
}
