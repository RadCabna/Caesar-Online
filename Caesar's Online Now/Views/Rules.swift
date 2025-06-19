//
//  Rules.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct Rules: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var rulesArray = Arrays.rulesArray
    @State private var ruleNumber = 0
    @State private var rulesOpacity: CGFloat = 1
    var body: some View {
        ZStack {
            Background(backgroundNumber: 4)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.1)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    coordinator.navigate(to: .mainMenu)
                }
            Image(rulesArray[ruleNumber])
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.7)
                .opacity(rulesOpacity)
                .onTapGesture {
                    changeRuleAnimation()
                }
        }
    }
    
    func changeRuleAnimation() {
        withAnimation(Animation.easeOut(duration: 0.5)) {
            rulesOpacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ruleNumber += 1
            if ruleNumber == rulesArray.count {
                ruleNumber = 0
            }
            withAnimation(Animation.easeOut(duration: 0.5)) {
                rulesOpacity = 1
            }
        }
    }
    
}

#Preview {
    Rules()
}
