//
//  ChoseLevel.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct ChoseLevel: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var levelsCountData = UserDefaults.standard.array(forKey: "levelsCountData") as? [Int] ?? [3,0,0,0,0,0]
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("yourLevelCount") var yourLevelCount = 0
    @AppStorage("enemyLevelCount") var enemyLevelCount = 0
    @State private var levelsOffset = Arrays.levelOffsetsArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.1)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    coordinator.navigate(to: .mainMenu)
                }
            Image("levelsPlate")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.17)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top)
            HStack(spacing: 0) {
                ForEach(0..<levelsCountData.count, id: \.self) { item in
                    if levelsCountData[item] >= 3 {
                        Image("openLevel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.14)
                            .offset(y: screenWidth*levelsOffset[item])
                            .onTapGesture {
                                levelNumber = item + 1
                                if levelNumber == 6 {
                                    levelNumber = 5
                                }
                                yourLevelCount = 0
                                enemyLevelCount = 0
                                coordinator.navigate(to: .game)
                            }
                    } else {
                        Image("closeLevel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.14)
                            .offset(y: screenWidth*levelsOffset[item])
                    }
                }
            }
            .offset(y: screenHeight*0.15)
        }
    }
}

#Preview {
    ChoseLevel()
}
