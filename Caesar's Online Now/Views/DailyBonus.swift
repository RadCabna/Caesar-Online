//
//  DailyBonus.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 19.06.2025.
//

import SwiftUI

struct DailyBonus: View {
    @AppStorage("isBonusActive") var isBonusActive = false
    @EnvironmentObject var coordinator: Coordinator
    @State private var tentsArray = Arrays.bonusTentArray
    @State private var shadowRadius: CGFloat = 0
    @State private var blinkTimer: Timer? = nil
    @State private var showBonus = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 3)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.1)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    coordinator.navigate(to: .mainMenu)
                }
            HStack(spacing: screenWidth*0.07) {
                ForEach(0..<3, id: \.self) { item in
                    ZStack {
                        Image("tentShadow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                            .scaleEffect(x: tentsArray[item].tentShadowScale, y: tentsArray[item].tentShadowScale)
                            .offset(y: screenWidth*0.065)
                            
                        Image("chest")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                            .offset(y: screenWidth*0.06)
                        Image(tentsArray[item].itemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.16)
                            .shadow(color: .white, radius: shadowRadius)
                            .shadow(color: .white, radius: shadowRadius)
                            .offset(y: tentsArray[item].yOffset)
                    }
                    .onTapGesture {
                        tapOnTent(item: item)
                    }
                }
            }
            .offset(y: -screenWidth*0.05)
            HStack(spacing: screenWidth*0.07) {
                ForEach(3..<5, id: \.self) { item in
                    ZStack {
                        Image("tentShadow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                            .scaleEffect(x: tentsArray[item].tentShadowScale, y: tentsArray[item].tentShadowScale)
                            .offset(y: screenWidth*0.065)
                            
                        Image("chest")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                            .offset(y: screenWidth*0.06)
                        Image(tentsArray[item].itemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.16)
                            .shadow(color: .white, radius: shadowRadius)
                            .shadow(color: .white, radius: shadowRadius)
                            .offset(y: tentsArray[item].yOffset)
                    }
                    .onTapGesture {
                        tapOnTent(item: item)
                    }
                }
            }
            .offset(y: screenWidth*0.05)
            
            if showBonus {
                GetBonus()
            }
        }
        
        .onAppear {
            if !isBonusActive {
                startBlinkTimer()
            }
        }
    }
    
    func tapOnTent(item: Int) {
        if !isBonusActive {
            withAnimation(Animation.easeInOut(duration: 1.5)) {
                tentsArray[item].yOffset = -screenWidth*0.1
                tentsArray[item].tentShadowScale = 1.5
            }
            isBonusActive.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showBonus.toggle()
            }
        }
    }
    
    func startBlinkTimer() {
        withAnimation(Animation.easeOut(duration: 0.5)) {
            shadowRadius = 5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeOut(duration: 0.5)) {
                shadowRadius = 0
            }
        }
        blinkTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true) { _ in
            if !isBonusActive {
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    shadowRadius = 5
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(Animation.easeOut(duration: 0.5)) {
                        shadowRadius = 0
                    }
                }
            }
        }
    }
    
    func stopBlinkTimer() {
        blinkTimer?.invalidate()
        blinkTimer = nil
    }
    
}

#Preview {
    DailyBonus()
}
