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
    @State private var yourSolder = Arrays.yourSolder
    @State private var enemySolder = Arrays.enemySolder
    @State private var ammunitionArray = Arrays.ammunitionArray
    @State private var enemyAmmunitionArray = Arrays.ammunitionArray
    @State private var yourHelmetOffset: CGFloat = 0
    @State private var enemyTentPositionX: CGFloat = 0
    @State private var enemyTentPositionY: CGFloat = 0
    @State private var yourTentPositionX: CGFloat = 0
    @State private var yourTentPositionY: CGFloat = 0
    @State private var enemyWarriorNumber = 0
    @State private var warriorNumber = 0
    @State private var ammunitionNumber = 0
    @State private var enemyAmmunitionNumber = 0
    @State private var selectedWarrior = "arrowWarrior"
    @State private var selectedEnemyWarrior = "arrowWarrior"
    @State private var yourCommandorName = "goodKnight2"
    @State private var enemyCommandorName = "evilKnight1"
    @State private var yourStage: Int = 0
    @State private var enemyStage: Int = 0
    @State private var choseWarriorFrameOffset: CGFloat = 1
    @State private var blinkRedTentTimer: Timer? = nil
    @State private var blinkBlueTentTimer: Timer? = nil
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
                ZStack {
                    Image(redTentArray[item].itemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width:screenWidth*0.07)
                        .offset(x: redTentArray[item].positionX*screenWidth/880, y: redTentArray[item].positionY*screenWidth/880)
                        .shadow(color: .white, radius: redTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
                        .shadow(color: .white, radius: redTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
                        .offset(y: redTentArray[item].itemName == "blastMark" ? screenWidth*0.02 : 0)
                    BoomSprite(startBoom: redTentArray[item].boomStart)
                        .offset(x: redTentArray[item].positionX*screenWidth/880, y: redTentArray[item].positionY*screenWidth/880)
                }
                    .onTapGesture {
                        selectYourTent(item: item)
                    }
            }
            ForEach(0..<blueTentArray.count, id: \.self) { item in
                ZStack {
                    Image(blueTentArray[item].itemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width:screenWidth*0.07)
                        .offset(x: blueTentArray[item].positionX*screenWidth/880, y: blueTentArray[item].positionY*screenWidth/880)
                        .shadow(color: .white, radius: blueTentArray[item].couldSelect ? blueTentArray[item].shadowRadius : 0)
                        .shadow(color: .white, radius: blueTentArray[item].couldSelect ? blueTentArray[item].shadowRadius : 0)
                        .offset(y: blueTentArray[item].itemName == "blastMark" ? screenWidth*0.02 : 0)
                    BoomSprite(startBoom: blueTentArray[item].boomStart)
                        .offset(x: blueTentArray[item].positionX*screenWidth/880, y: blueTentArray[item].positionY*screenWidth/880)
                }
                    .onTapGesture {
                        tapOnTargetTent(item: item)
                    }
                    
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
                            .offset(y: -screenWidth*0.1)
                    }
                    Image("commandorStand")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .offset(y: screenWidth*0.07)
                    Image(yourCommandorName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                }
                Spacer()
                ZStack {
                    if enemyWarriorNumber != 0 {
                        Image(selectedEnemyWarrior)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.05)
                            .offset(y: -screenWidth*0.1)
                    }
                    Image("commandorStand")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .offset(y: screenWidth*0.06)
                    Image(enemyCommandorName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                }
            }
            Group {
                Image(yourSolder.itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.05)
                    .offset(x: yourSolder.positionX*screenWidth/880, y: yourSolder.positionY*screenWidth/880)
                    .shadow(color: .black, radius: 4)
                    .offset(y: yourHelmetOffset)
                Image(ammunitionArray[ammunitionNumber].itemName)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: ammunitionArray[ammunitionNumber].angle))
                    .frame(maxWidth: screenWidth*0.1, maxHeight: screenHeight*0.1)
                    .offset(x: ammunitionArray[ammunitionNumber].positionX*screenWidth/880, y: ammunitionArray[ammunitionNumber].positionY*screenWidth/880)
                    .opacity(ammunitionArray[ammunitionNumber].opacity)
            }
            Group {
                Image(enemySolder.itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.05)
                    .offset(x: enemySolder.positionX*screenWidth/880, y: enemySolder.positionY*screenWidth/880)
                    .shadow(color: .black, radius: 4)
                    .offset(y: yourHelmetOffset)
                    .opacity(enemySolder.opacity)
                Image(enemyAmmunitionArray[enemyAmmunitionNumber].itemName)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: enemyAmmunitionArray[enemyAmmunitionNumber].angle))
                    .frame(maxWidth: screenWidth*0.1, maxHeight: screenHeight*0.1)
                    .offset(x: enemyAmmunitionArray[enemyAmmunitionNumber].positionX*screenWidth/880, y: enemyAmmunitionArray[enemyAmmunitionNumber].positionY*screenWidth/880)
                    .opacity(enemyAmmunitionArray[enemyAmmunitionNumber].opacity)
            }
        }
        
        .onChange(of: yourStage) { _ in
        showPossibleSteps()
        }
        
        .onChange(of: enemyStage) { _ in
                enemyAttack()
            enemySelectTent()
        }
        
        .onChange(of: yourTurn) { _ in
        showPossibleSteps()
        }
        
        .onAppear {
//            showPossibleSteps()
            showChoseWarriorFrame()
            helmetAnimation()
        }
    }
    
    func tapOnTargetTent(item: Int) {
        if blueTentArray[item].couldSelect && blueTentArray[item].itemName != "blastMark" {
            enemyTentPositionX = blueTentArray[item].positionX
            enemyTentPositionY = blueTentArray[item].positionY
            ammunitionAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                blueTentArray[item].boomStart.toggle()
                blueTentArray[item].itemName = "blastMark"
            }
        }
        hidePossibleSteps()
        if blueTentArray[item].haveHelmet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation() {
                    enemySolder.opacity = 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                enemyStage = 0
                withAnimation() {
                    enemySolder = Arrays.enemySolder
                }
                yourTurn.toggle()
                yourStage = 3
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
             enemyStage = 2
                yourTurn.toggle()
                yourStage = 3
            }
        }
    }
    
    func ammunitionAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            ammunitionArray[ammunitionNumber].opacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear(duration: 1.5)) {
                ammunitionArray[ammunitionNumber].positionY = -700
                ammunitionArray[ammunitionNumber].positionX = -100
            }
        }
        if  ammunitionArray[ammunitionNumber].itemName == "ball" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    ammunitionArray[ammunitionNumber].itemName = "fireball"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                ammunitionArray[ammunitionNumber].itemName = "ball"
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if ammunitionArray[ammunitionNumber].itemName == "fireball" {
                ammunitionArray[ammunitionNumber].angle = 80
            } else {
                ammunitionArray[ammunitionNumber].angle = 260
            }
            ammunitionArray[ammunitionNumber].positionX = 50
            withAnimation(Animation.easeIn(duration: 2)) {
                ammunitionArray[ammunitionNumber].positionY = enemyTentPositionY
                ammunitionArray[ammunitionNumber].positionX = enemyTentPositionX
            }
        }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.9) {
            withAnimation(Animation.easeInOut(duration: 0.1)) {
                ammunitionArray[ammunitionNumber].opacity = 0
            }
        }
        
    }
    
    func selectYourTent(item: Int) {
        if redTentArray[item].couldSelect {
//            .offset(x: yourSolder.positionX*screenWidth/880, y: yourSolder.positionY*screenWidth/880)
            ammunitionArray[ammunitionNumber].positionX = redTentArray[item].positionX
            ammunitionArray[ammunitionNumber].positionY = redTentArray[item].positionY
            withAnimation(Animation.easeInOut(duration: 1.5)) {
                yourSolder.positionX = redTentArray[item].positionX
                yourSolder.positionY = redTentArray[item].positionY
                redTentArray[item].haveHelmet = true
            }
            hidePossibleSteps()
            yourTurn.toggle()
            yourStage = 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                enemySelectTent()
            }
        }
    }
    
    func enemySelectTent() {
        if !yourTurn && enemyStage == 0 {
            var randomePosition = 0
            withAnimation() {
//                enemyWarriorNumber = Int.random(in: 1...3)
                enemyWarriorNumber = 1
                enemyAmmunitionNumber = enemyWarriorNumber - 1
                updateEnemyWarriorSign()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                repeat {
                    randomePosition = Int.random(in: 0..<5)
                } while blueTentArray[randomePosition].itemName == "blastMark"
                withAnimation(Animation.easeInOut(duration: 1.5)) {
                    enemySolder.opacity = 0
                }
                blueTentArray[randomePosition].haveHelmet = true
                enemyAmmunitionArray[enemyAmmunitionNumber].positionX = 307
                enemyAmmunitionArray[enemyAmmunitionNumber].positionY = 93
                if enemyAmmunitionArray[enemyAmmunitionNumber].itemName == "ball" {
                    enemyAmmunitionArray[enemyAmmunitionNumber].angle = 250
                } else {
                    enemyAmmunitionArray[enemyAmmunitionNumber].angle = 70
                }
                enemyStage = 1
                yourTurn.toggle()
            }
        }
    }
    
    func enemyAttack() {
        if !yourTurn && enemyStage == 2 {
            let possibleIndex = [1,2,3,4,5]
            var possibleRedTentTargetArray: [Tent] = []
            for i in 0..<redTentArray.count {
                if !redTentArray[i].crashed && possibleIndex.contains(redTentArray[i].tentPosition) {
                    possibleRedTentTargetArray.append(redTentArray[i])
                }
            }
            let randomeIndex = Int.random(in: 0..<possibleRedTentTargetArray.count-1)
            yourTentPositionX = redTentArray[randomeIndex].positionX
            yourTentPositionY = redTentArray[randomeIndex].positionY
            withAnimation(Animation.easeInOut(duration: 1)) {
                enemyAmmunitionArray[enemyAmmunitionNumber].opacity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(Animation.linear(duration: 1.5)) {
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionY = -700
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionX = -100
                }
            }
            if  enemyAmmunitionArray[enemyAmmunitionNumber].itemName == "ball" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    enemyAmmunitionArray[enemyAmmunitionNumber].itemName = "fireball"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    enemyAmmunitionArray[enemyAmmunitionNumber].itemName = "ball"
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if enemyAmmunitionArray[enemyAmmunitionNumber].itemName == "fireball" {
                    enemyAmmunitionArray[enemyAmmunitionNumber].angle = 120
                } else {
                    enemyAmmunitionArray[enemyAmmunitionNumber].angle = 300
                }
                enemyAmmunitionArray[enemyAmmunitionNumber].positionX = 50
                withAnimation(Animation.easeIn(duration: 2)) {
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionY = yourTentPositionY
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionX = yourTentPositionX
                }
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9) {
                withAnimation(Animation.easeInOut(duration: 0.1)) {
                    enemyAmmunitionArray[enemyAmmunitionNumber].opacity = 0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                redTentArray[randomeIndex].boomStart.toggle()
                redTentArray[randomeIndex].itemName = "blastMark"
            }
            if redTentArray[randomeIndex].haveHelmet {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation() {
                        yourSolder.opacity = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    yourStage = 0
                    withAnimation() {
                        yourSolder = Arrays.yourSolder
                    }
                    yourTurn.toggle()
                    enemyStage = 3
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                 yourStage = 2
                    yourTurn.toggle()
                    enemyStage = 3
                }
            }
        }
    }
    
    func helmetAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            yourHelmetOffset = -10
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
    
    func updateEnemyWarriorSign() {
        switch enemyWarriorNumber {
        case 2:
            selectedEnemyWarrior = "flameBallWarrior"
        case 3:
            selectedEnemyWarrior = "spearWarrior"
        default:
            selectedEnemyWarrior = "arrowWarrior"
        }
    }
    
    func selectWarrior(item: Int) {
        withAnimation() {
            warriorNumber = item+1
        }
        ammunitionNumber = item
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
    
    func hidePossibleSteps() {
        for i in 0..<redTentArray.count {
            redTentArray[i].couldSelect = false
            blueTentArray[i].couldSelect = false
        }
    }
    
    func showPossibleSteps() {
        if yourTurn {
            if yourStage == 1 {
                let possiblePositions = [1,2,3,4,5]
                for i in 0..<redTentArray.count {
                    if possiblePositions.contains(redTentArray[i].tentPosition) && redTentArray[i].itemName != "blastMark" {
                        redTentArray[i].couldSelect = true
                    } else {
                        redTentArray[i].couldSelect = false
                    }
                }
                blinkRedTentShadow()
            }
            if yourStage == 2 {
                let possiblePositions = [1,2,3,4,5]
                for i in 0..<blueTentArray.count {
                    if possiblePositions.contains(blueTentArray[i].tentPosition) && blueTentArray[i].itemName != "blastMark" {
                        blueTentArray[i].couldSelect = true
                    } else {
                        blueTentArray[i].couldSelect = false
                    }
                }
                blinkBlueTentShadow()
            }
            if yourStage == 3 {
                let possiblePositions = [6,7,8,9]
                for i in 0..<redTentArray.count {
                    if possiblePositions.contains(redTentArray[i].tentPosition) && redTentArray[i].itemName != "blastMark" {
                        redTentArray[i].couldSelect = true
                    } else {
                        redTentArray[i].couldSelect = false
                    }
                }
                blinkRedTentShadow()
            }
        }
    }
    
    func blinkRedTentShadow() {
        for i in 0..<redTentArray.count {
            blinkRedTentTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true) { _ in
                if redTentArray[i].couldSelect && redTentArray[i].itemName != "blastMark"{
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        redTentArray[i].shadowRadius = 5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            redTentArray[i].shadowRadius = 0
                        }
                    }
                }
            }
        }
    }
    
    func stopBlinkRedTentShadow() {
        blinkRedTentTimer?.invalidate()
        blinkRedTentTimer = nil
    }
    
    func blinkBlueTentShadow() {
        for i in 0..<blueTentArray.count {
            blinkBlueTentTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true) { _ in
                if blueTentArray[i].couldSelect && blueTentArray[i].itemName != "blastMark"{
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        blueTentArray[i].shadowRadius = 5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            blueTentArray[i].shadowRadius = 0
                        }
                    }
                }
            }
        }
    }
    
    func stopBlinkBlueTentShadow() {
        blinkBlueTentTimer?.invalidate()
        blinkBlueTentTimer = nil
    }
    
}

#Preview {
    Game()
}
