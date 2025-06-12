//
//  Game.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct Game: View {
    @AppStorage("yourCommandorNumber") var yourCommandorNumber = 1
    @AppStorage("enemyCommandorNumber") var enemyCommandorNumber = 1
    @State private var yourTurn: Bool = true
    @State private var redTentArray = Arrays.redTensArray
    @State private var blueTentArray = Arrays.blueTensArray
    @State private var warriorArray = Arrays.warriorArray
    @State private var warriorNumber = 0
    @State private var selectedWarrior = "arrowWarrior"
    @State private var yourCommandorName = "goodKnight2"
    @State private var enemyCommandorName = "evilKnight1"
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var yourStage: Int = 0
    @State private var enemyStage: Int = 0
    @State private var choseWarriorFrameOffset: CGFloat = 1
    var body: some View {
        ZStack {
            Background(backgroundNumber: 6)
            Image("pauseButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.07)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
            HStack(spacing: screenWidth*0.1) {
                Image("actionFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.13)
                    .overlay(
                        Image(yourTurn ? "goText" : "waitText")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: screenWidth*0.09, maxHeight: screenWidth*0.03)
                    )
                Image("scoreFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.18)
                Image("actionFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.13)
                    .overlay(
                        Image(!yourTurn ? "goText" : "waitText")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: screenWidth*0.09, maxHeight: screenWidth*0.03)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            ForEach(0..<redTentArray.count, id: \.self) { item in
                Image(redTentArray[item].itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(height:screenWidth*0.08)
                    .offset(x: redTentArray[item].positionX*screenWidth/880, y: redTentArray[item].positionY*screenWidth/880)
                    .shadow(color: .white, radius: redTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
                    .shadow(color: .white, radius: redTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
//                    .gesture(
//                           DragGesture()
//                               .onChanged { value in
//                                   redTentArray[item].offsetX = value.translation.width
//                                   redTentArray[item].offsetY = value.translation.height
//                                   redTentArray[item].positionX = redTentArray[item].offsetX
//                                   redTentArray[item].positionY = redTentArray[item].offsetY
//                                  
//                               }
//                               .onEnded { value in
//                                   
//                                   redTentArray[item].positionX += redTentArray[item].offsetX
//                                   redTentArray[item].positionY += redTentArray[item].offsetY
//                                   print("Current offset - X: \(redTentArray[item].positionX), Y: \(redTentArray[item].positionY)")
//
//                                   redTentArray[item].offsetX = 0
//                                   redTentArray[item].offsetY = 0
//                               }
//                       )
            }
            ForEach(0..<blueTentArray.count, id: \.self) { item in
                Image(blueTentArray[item].itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(height:screenWidth*0.08)
                    .offset(x: blueTentArray[item].positionX*screenWidth/880, y: blueTentArray[item].positionY*screenWidth/880)
                    .shadow(color: .white, radius: blueTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
                    .shadow(color: .white, radius: blueTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
            }
            ZStack {
                Image("choseWarriorFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.35)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                HStack {
                    ForEach(0..<warriorArray.count, id: \.self) { item in
                        ZStack {
                            Image(warriorArray[item].itemName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .scaleEffect(x: warriorArray[item].shadowScale, y: warriorArray[item].shadowScale)
                                .opacity(warriorArray[item].opacity)
                            Image(warriorArray[item].itemName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                        }
                        .onTapGesture {
                            selectWarrior(item: item)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, screenHeight*0.01)
                .ignoresSafeArea()
               
            }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                .offset(y: screenWidth*0.2*choseWarriorFrameOffset)
            HStack {
                ZStack {
                    if warriorNumber != 0 {
                        Image(selectedWarrior)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.05)
                            .offset(y: -screenHeight*0.22)
                    }
                    Image("commandorStand")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .offset(y: screenHeight*0.13)
                    Image(yourCommandorName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                }
                Spacer()
                ZStack {
                    Image("commandorStand")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .offset(y: screenHeight*0.13)
                    Image(enemyCommandorName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                }
            }
        }
        
        .onChange(of: yourStage) { _ in
        showPossibleSteps()
        }
        
        .onAppear {
//            showPossibleSteps()
            showChoseWarriorFrame()
        }
    }
    
    func updateWarriorSign() {
        switch warriorNumber {
        case 2:
            selectedWarrior = "flameBallWarrior"
        case 3:
            selectedWarrior = "spearWarrior"
        default:
            selectedWarrior = "arrowWarrior"
        }
    }
    
    func selectWarrior(item: Int) {
        withAnimation() {
            warriorNumber = item+1
        }
        updateWarriorSign()
        withAnimation(Animation.easeInOut(duration: 1)) {
            warriorArray[item].opacity = 0
            warriorArray[item].shadowScale = 2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            closeChoseWarriorFrame()
            yourStage = 1
        }
    }
    
    func showChoseWarriorFrame() {
        withAnimation(Animation.linear(duration: 1)) {
            choseWarriorFrameOffset = 0
        }
    }
    
    func closeChoseWarriorFrame() {
        withAnimation(Animation.linear(duration: 1)) {
            choseWarriorFrameOffset = 1
        }
    }
    
    func showPossibleSteps() {
        if yourTurn && yourStage == 1 {
            let possiblePositions = [1,2,3,4,5]
            for i in 0..<redTentArray.count {
                if possiblePositions.contains(redTentArray[i].tentPosition) {
                    redTentArray[i].couldSelect = true
                } else {
                    redTentArray[i].couldSelect = false
                }
            }
            blinkRedTentShadow()
        }
    }
    
    func blinkRedTentShadow() {
        for i in 0..<redTentArray.count {
            if redTentArray[i].couldSelect {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    redTentArray[i].shadowRadius = 5
                }
            }
        }
    }
    
}

#Preview {
    Game()
}
