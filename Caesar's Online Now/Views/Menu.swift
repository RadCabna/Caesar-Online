//
//  Menu.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var settingsRotation: CGFloat = 0
    @AppStorage("coinCount") var coinCount = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 2)
            HStack {
                Image("settingsButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .rotationEffect(Angle(degrees: settingsRotation))
                    .onTapGesture {
                        coordinator.navigate(to: .settings)
                    }
                Spacer()
                Image("coinFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.2)
                    .overlay(
                        Text("\(coinCount)")
                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.023))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .offset(x: -screenWidth*0.035)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            VStack {
                Image("logoText")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.35)
                    .shadow(color: .black, radius: 5)
                Image("playButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.3)
                    .onTapGesture {
                        coordinator.navigate(to: .choseLevel)
                    }
            }
            VStack {
                Image("dailyButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        coordinator.navigate(to: .bonus)
                    }
                Image("rulesButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        coordinator.navigate(to: .rules)
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
            Image("shopButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.13)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding()
                .onTapGesture {
                    coordinator.navigate(to: .shop)
                }
        }
        
        .onAppear {
            settingsRotationAnimation()
        }
        
    }
    
    func settingsRotationAnimation() {
        withAnimation(Animation.linear(duration: 10)) {
            settingsRotation = 360
        }
    }
    
}

#Preview {
    Menu()
}
