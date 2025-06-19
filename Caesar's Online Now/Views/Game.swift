//
//  Game.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct Game: View {
    @AppStorage("yourCommandorNumber") var yourCommandorNumber = 0
    @AppStorage("enemyCommandorNumber") var enemyCommandorNumber = 0
    @AppStorage("yourLevelCount") var yourLevelCount = 0
    @AppStorage("enemyLevelCount") var enemyLevelCount = 0
    @AppStorage("levelNumber") var levelNumber = 1
    @State private var levelsCountData = UserDefaults.standard.array(forKey: "levelsCountData") as? [Int] ?? [3,0,0,0,0,0]
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
    @State private var winPodOpacity: CGFloat = 0
    @State private var enemyWarriorNumber = 0
    @State private var warriorNumber = 0
    @State private var ammunitionNumber = 0
    @State private var enemyAmmunitionNumber = 0
    @State private var selectedWarrior = "arrowWarrior"
    @State private var selectedEnemyWarrior = "arrowWarrior"
    @State private var yourCommandorName = "goodKnight1"
    @State private var enemyCommandorName = "evilKnight1"
    @State private var yourStage: Int = 0
    @State private var enemyStage: Int = 0
    @State private var choseWarriorFrameOffset: CGFloat = 1
    @State private var blinkRedTentTimer: Timer? = nil
    @State private var blinkBlueTentTimer: Timer? = nil
    @State private var youWin: Bool = false
    @State private var youLose: Bool = false
    @State private var showPause = false
    @State private var timerCount = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 6)
            HStack {
                ZStack {
                    if warriorNumber != 0 {
                        Image(selectedWarrior)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.05)
                            .offset(y: -screenWidth*0.1)
                    }
//                    Image("commandorStand")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: screenWidth*0.08)
//                        .offset(y: screenWidth*0.05)
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
//                    Image("commandorStand")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: screenWidth*0.08)
//                        .offset(y: screenWidth*0.06)
                    Image(enemyCommandorName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                }
            }
            ForEach(0..<redTentArray.count, id: \.self) { item in
                ZStack {
                    Image(redTentArray[item].itemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width:screenWidth*0.07)
                        .offset(x: redTentArray[item].positionX*screenWidth/880, y: redTentArray[item].positionY*screenWidth/880)
                        .shadow(color: .blue, radius: redTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
                        .shadow(color: .blue, radius: redTentArray[item].couldSelect ? redTentArray[item].shadowRadius : 0)
                        .offset(y: redTentArray[item].itemName == "blastMark" ? screenWidth*0.02 : 0)
                    BoomSprite(startBoom: redTentArray[item].boomStart)
                        .offset(x: redTentArray[item].positionX*screenWidth/880, y: redTentArray[item].positionY*screenWidth/880)
                    SmokeSprite(startSmoke: redTentArray[item].smokeStart)
                        .offset(x: redTentArray[item].positionX*screenWidth/880, y: redTentArray[item].positionY*screenWidth/880)
                    SmokeSprite(startSmoke: redTentArray[item].smokeStart)
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
                        .shadow(color: .red, radius: blueTentArray[item].couldSelect ? blueTentArray[item].shadowRadius : 0)
                        .shadow(color: .red, radius: blueTentArray[item].couldSelect ? blueTentArray[item].shadowRadius : 0)
                        .offset(y: blueTentArray[item].itemName == "blastMark" ? screenWidth*0.02 : 0)
                    BoomSprite(startBoom: blueTentArray[item].boomStart)
                        .offset(x: blueTentArray[item].positionX*screenWidth/880, y: blueTentArray[item].positionY*screenWidth/880)
                    SmokeSprite(startSmoke: blueTentArray[item].smokeStart)
                        .offset(x: blueTentArray[item].positionX*screenWidth/880, y: blueTentArray[item].positionY*screenWidth/880)
                    SmokeSprite(startSmoke: blueTentArray[item].smokeStart)
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
                            youSelectWarrior(item: item)
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
            Image("pauseButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.07)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .onTapGesture {
                    showPause.toggle()
                }
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
                    .overlay(
                        Text("\(yourLevelCount) : \(enemyLevelCount)")
                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.025))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .offset(y: screenWidth*0.017)
                    )
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
            Image("winPod")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.1)
                .offset(y: screenWidth*0.08)
                .opacity(winPodOpacity)
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
            if showPause {
                Pause(showPause: $showPause)
            }
            if youLose {
                YouLose(youLose: $youLose)
            }
            if youWin {
                YouWin(youWin: $youWin)
            }
        }
        
        .onChange(of: yourStage) { _ in
        showPossibleSteps()
           
        }
        
        .onChange(of: enemyStage) { _ in
            if enemyStage == 0 {
                enemySelectWarrior()
            }
        }
        
        .onChange(of: youWin) { _ in
        if !youWin {
               resetGame()
            }
        }
        
        .onChange(of: yourTurn) { _ in
            if enemyStage == 0 {
                enemySelectWarrior()
            }
            if !yourTurn && enemyStage == 9 {
                enemyGoToPodium()
            }
            if yourTurn && yourStage == 9 {
                youGoToPodium()
            }
            checkGameEnded()
            showPossibleSteps()
            gameStagesController()
            print("---")
            print(yourTurn)
            print(yourStage)
            print(enemyStage)
            print(yourTurn)
        }
        
        .onAppear {
            print("---")
            print(yourTurn)
            print(yourStage)
            print(enemyStage)
            print(yourTurn)
            updateCommandors()
            showChoseWarriorFrame()
            helmetAnimation()
        }
    }
    
    func checkGameEnded() {
        if redTentArray[0].itemName == "blastMark" &&
            redTentArray[1].itemName == "blastMark" &&
            redTentArray[2].itemName == "blastMark" &&
            redTentArray[3].itemName == "blastMark" &&
            redTentArray[4].itemName == "blastMark" {
            youLose = true
        }
        if redTentArray[12].itemName == "blastMark" &&
            redTentArray[13].itemName == "blastMark" {
            youLose = true
        }
        if blueTentArray[0].itemName == "blastMark" &&
            blueTentArray[1].itemName == "blastMark" &&
            blueTentArray[2].itemName == "blastMark" &&
            blueTentArray[3].itemName == "blastMark" &&
            blueTentArray[4].itemName == "blastMark" {
            youWin = true
        }
        if blueTentArray[12].itemName == "blastMark" &&
            blueTentArray[13].itemName == "blastMark" {
            youLose = true
        }
        
    }
    
    func resetGame() {
        redTentArray = Arrays.redTensArray
        blueTentArray = Arrays.blueTensArray
        yourSolder = Arrays.yourSolder
        enemySolder = Arrays.enemySolder
        winPodOpacity = 0
        yourStage = 0
        enemyStage = 0
        showChoseWarriorFrame()
        stopBlinkRedTentShadow()
        stopBlinkBlueTentShadow()
        enemyWarriorNumber = 0
        warriorNumber = 0

    }
    
    func youGoToPodium() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            winPodOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(Animation.easeInOut(duration: 1)) {
                yourSolder.positionX = 0
                yourSolder.positionY = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            youWin = true
        }
    }
    
    func enemyGoToPodium() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            winPodOpacity = 1
            enemySolder.opacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(Animation.easeInOut(duration: 1)) {
                enemySolder.positionX = 0
                enemySolder.positionY = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            youLose = true
        }
    }
    
    func gameStagesController() {
        switch enemyStage {
        case 1:
            enemySelectTent()
        case 2:
            enemyAttack()
        case 3:
            enemySelectTent()
        case 4:
            enemyAttack()
        case 5:
            enemySelectTent()
        case 6:
            enemyAttack()
        case 7:
            enemySelectTent()
        case 8:
            enemyAttack()
        case 9:
            enemySelectTent()
        default:
            showPossibleSteps()
        }
    }
    
    func tapOnTargetTent(item: Int) {
        if blueTentArray[item].couldSelect && blueTentArray[item].itemName != "blastMark" {
            enemyTentPositionX = blueTentArray[item].positionX
            enemyTentPositionY = blueTentArray[item].positionY
            ammunitionAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if warriorNumber == 2 {
                    blueTentArray[item].boomStart.toggle()
                } else {
                    blueTentArray[item].smokeStart.toggle()
                }
                blueTentArray[item].itemName = "blastMark"
            }
        }
        hidePossibleSteps()
        stopBlinkRedTentShadow()
        stopBlinkBlueTentShadow()
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
                yourStage += 1
                yourTurn.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) {
//                if enemyStage == 1 {
//                    enemyStage += 1
//                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                yourTurn.toggle()
                yourStage += 1
            }
        }
    }
    
    func ammunitionAnimation() {
        ammunitionArray[ammunitionNumber].angle = Arrays.ammunitionArray[ammunitionNumber].angle
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
        print("---")
        print(yourTurn)
        print(yourStage)
        print(enemyStage)
        print(yourTurn)
        if redTentArray[item].couldSelect {
            ammunitionArray[ammunitionNumber].positionX = redTentArray[item].positionX
            ammunitionArray[ammunitionNumber].positionY = redTentArray[item].positionY
            withAnimation(Animation.easeInOut(duration: 1.5)) {
                yourSolder.positionX = redTentArray[item].positionX
                yourSolder.positionY = redTentArray[item].positionY
                for i in 0..<redTentArray.count {
                    redTentArray[i].haveHelmet = false
                }
                redTentArray[item].haveHelmet = true
            }
            hidePossibleSteps()
            stopBlinkRedTentShadow()
            stopBlinkBlueTentShadow()
            yourTurn.toggle()
            yourStage += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                enemySelectTent()
                enemyStage += 1
            }
        }
    }
    
    func enemySelectTent() {
        if !yourTurn && (enemyStage == 1 || enemyStage == 3 || enemyStage == 5 || enemyStage == 7) {
            var randomePosition = 10
            repeat {
                if enemyStage == 1 {
                    randomePosition = Int.random(in: 0..<5)
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionX = 307
                }
                if enemyStage == 3 {
                    randomePosition = Int.random(in: 5..<9)
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionX = 224
                }
                if enemyStage == 5 {
                    randomePosition = Int.random(in: 9..<12)
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionX = 147
                }
                if enemyStage == 7 {
                    randomePosition = Int.random(in: 12..<14)
                    enemyAmmunitionArray[enemyAmmunitionNumber].positionX = 63
                }
            } while blueTentArray[randomePosition].itemName == "blastMark"
//            if enemyStage == 0 {
//                enemySelectWarrior()
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(Animation.easeInOut(duration: 1.5)) {
                    enemySolder.opacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(Animation.easeInOut(duration: 1.5)) {
                    enemySolder.positionX = blueTentArray[randomePosition].positionX
                    enemySolder.positionY = blueTentArray[randomePosition].positionY
                }
                for i in 0..<blueTentArray.count {
                    blueTentArray[i].haveHelmet = false
                }
                blueTentArray[randomePosition].haveHelmet = true
                
                enemyAmmunitionArray[enemyAmmunitionNumber].positionY = 93
                if enemyAmmunitionArray[enemyAmmunitionNumber].itemName == "ball" {
                    enemyAmmunitionArray[enemyAmmunitionNumber].angle = 250
                } else {
                    enemyAmmunitionArray[enemyAmmunitionNumber].angle = 70
                }
                yourTurn.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                if enemyStage == 1 {
//                    enemyStage += 1
//                }
            }
        }
    }
    
    func updateCommandors() {
        switch yourCommandorNumber {
        case 1:
            yourCommandorName = "goodKnight2"
        case 2:
            yourCommandorName = "goodKnight3"
        case 3:
            yourCommandorName = "goodKnight4"
        case 4:
            yourCommandorName = "goodKnight5"
        case 5:
            yourCommandorName = "goodKnight6"
        default:
            yourCommandorName = "goodKnight1"
        }
        
        switch enemyCommandorNumber {
        case 1:
            enemyCommandorName = "evilKnight2"
        case 2:
            enemyCommandorName = "evilKnight3"
        case 3:
            enemyCommandorName = "evilKnight4"
        case 4:
            enemyCommandorName = "evilKnight5"
        case 5:
            enemyCommandorName = "evilKnight6"
        default:
            enemyCommandorName = "evilKnight1"
        }
        
    }
    
    func enemyAttack() {
        if !yourTurn && (enemyStage == 2 || enemyStage == 4 || enemyStage == 6 || enemyStage == 8) {
            var possibleIndex: [Int] = [0,1,2,3,4]
            switch yourStage {
            case 3:
                possibleIndex = [0,1,2,3,4]
            case 5:
                possibleIndex = [5,6,7,8]
            case 7:
                possibleIndex = [9,10,11]
            case 9:
                possibleIndex = [12,13]
            default:
                possibleIndex = [0,1,2,3,4]
            }
           
           
            var randomeIndex = 0
            repeat {
                randomeIndex = possibleIndex.randomElement() ?? 0
            } while redTentArray[randomeIndex].itemName == "blastMark"
//            randomeIndex =  0
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
//                if warriorNumber == 2 {
//                    blueTentArray[item].boomStart.toggle()
//                } else {
//                    blueTentArray[item].smokeStart.toggle()
//                }
                if enemyWarriorNumber == 2 {
                    redTentArray[randomeIndex].boomStart.toggle()
                } else {
                    redTentArray[randomeIndex].smokeStart.toggle()
                }
                redTentArray[randomeIndex].itemName = "blastMark"
            }
            if redTentArray[randomeIndex].haveHelmet {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation() {
                        yourSolder.opacity = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    yourStage = 1
                    withAnimation() {
                        yourSolder = Arrays.yourSolder
                    }
                    yourTurn.toggle()
                    enemyStage += 1
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    yourTurn.toggle()
                    enemyStage += 1
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
    
    func enemySelectWarrior() {
        withAnimation() {
            enemyWarriorNumber = Int.random(in: 1...3)
            enemyAmmunitionNumber = enemyWarriorNumber - 1
        }
        updateEnemyWarriorSign()
        enemyStage += 1
    }
    
    func youSelectWarrior(item: Int) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            warriorArray[item].opacity = 1
            warriorArray[item].shadowScale = 1
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
    
    func updateYourPosileStaps() -> [Int]{
        var possiblePositions = [1,2,3,4,5]
        switch enemyStage {
        case 2:
            possiblePositions = [1,2,3,4,5]
        case 3:
            possiblePositions = [1,2,3,4,5]
        case 4:
            possiblePositions = [6,7,8,9]
        case 5:
            possiblePositions = [6,7,8,9]
        case 6:
            possiblePositions = [10,11,12]
        case 7:
            possiblePositions = [10,11,12]
        case 8:
            possiblePositions = [13,14]
        case 9:
            possiblePositions = [13,14]
        default:
            possiblePositions = [1,2,3,4,5]
        }
        return possiblePositions
    }
    
    func showPossibleSteps() {
        guard yourTurn else { return }
        
        let possiblePositions: [Int]
        var isRedTent = false
        
        switch yourStage {
        case 1:
            possiblePositions = [1, 2, 3, 4, 5]
            isRedTent = true
        case 2:
            possiblePositions = updateYourPosileStaps()
        case 3:
            possiblePositions = [6, 7, 8, 9]
            isRedTent = true
        case 4:
            possiblePositions = updateYourPosileStaps()
        case 5:
            possiblePositions = [10, 11, 12]
            isRedTent = true
        case 6:
            possiblePositions = updateYourPosileStaps()
        case 7:
            possiblePositions = [13, 14]
            isRedTent = true
        case 8:
            possiblePositions = updateYourPosileStaps()
        default:
            return
        }
        
        if isRedTent {
            for i in 0..<redTentArray.count {
                redTentArray[i].couldSelect = possiblePositions.contains(redTentArray[i].tentPosition) &&
                                              redTentArray[i].itemName != "blastMark"
            }
            blinkRedTentShadow()
        } else {
            for i in 0..<blueTentArray.count {
                blueTentArray[i].couldSelect = possiblePositions.contains(blueTentArray[i].tentPosition) &&
                                               blueTentArray[i].itemName != "blastMark"
            }
            blinkBlueTentShadow()
        }
    }
    
    func blinkRedTentShadow() {
        timerCount += 1
        print(timerCount)
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
        timerCount -= 1
        print(timerCount)
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
