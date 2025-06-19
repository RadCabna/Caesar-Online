//
//  Shop.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("yourCommandorNumber") var yourCommandorNumber = 0
    @AppStorage("enemyCommandorNumber") var enemyCommandorNumber = 0
    @State private var shopItemsGoodArray = Arrays.shopItemsGoodArray
    @State private var shopItemsEvelArray = Arrays.shopItemsEvelArray
    @State private var shopItemsGoodData = UserDefaults.standard.array(forKey: "shopItemsGoodData") as? [Int] ?? [2,0,0,0,0,0]
    @State private var shopItemsEvelData = UserDefaults.standard.array(forKey: "shopItemsEvelData") as? [Int] ?? [2,0,0,0,0,0]
    @State private var shopItemsOffset = 0.363
    @State private var shopSet = 1
    var body: some View {
        ZStack {
            Background(backgroundNumber: 5)
           
            if shopSet == 1 {
                Image("shopGoodFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.8)
                    .offset(y: screenWidth*0.02)
                    .overlay(
                        ZStack {
                            HStack(spacing: screenWidth*0.04) {
                                ForEach(0..<3, id: \.self) {item in
                                    ZStack {
                                        Image("shopItemFrame")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.2)
                                        Image(shopItemsGoodArray[item].itemName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: screenWidth*0.1, maxHeight: screenWidth*0.18)
                                        if shopItemsGoodData[item] == 2 {
                                            Image("selectedShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.06)
                                                .offset(y: screenWidth*0.11)
                                        }
                                        if shopItemsGoodData[item] == 1 {
                                            Image("selectShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.086)
                                                .offset(y: screenWidth*0.11)
                                                .onTapGesture {
                                                    selectGoodWarrior(item: item)
                                                }
                                        }
                                        if shopItemsGoodData[item] == 0 {
                                            if coinCount >= shopItemsGoodArray[item].cost {
                                                Image("greenShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsGoodArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                                    .onTapGesture {
                                                        buyGoodWarrior(item: item)
                                                    }
                                            } else {
                                                Image("redShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsGoodArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                            }
                                        }
                                    }
                                }
                            }
                            .offset(x: -screenWidth*0.363)
                            HStack(spacing: screenWidth*0.04) {
                                ForEach(3..<6, id: \.self) {item in
                                    ZStack {
                                        Image("shopItemFrame")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.2)
                                        Image(shopItemsGoodArray[item].itemName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: screenWidth*0.1, maxHeight: screenWidth*0.18)
                                        if shopItemsGoodData[item] == 2 {
                                            Image("selectedShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.06)
                                                .offset(y: screenWidth*0.11)
                                        }
                                        if shopItemsGoodData[item] == 1 {
                                            Image("selectShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.086)
                                                .offset(y: screenWidth*0.11)
                                                .onTapGesture {
                                                    selectGoodWarrior(item: item)
                                                }
                                        }
                                        if shopItemsGoodData[item] == 0 {
                                            if coinCount >= shopItemsGoodArray[item].cost {
                                                Image("greenShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsGoodArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                                    .onTapGesture {
                                                        buyGoodWarrior(item: item)
                                                    }
                                            } else {
                                                Image("redShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsGoodArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                            }
                                        }
                                    }
                                }
                            }
                            .offset(x: screenWidth*0.363)
                        }
                            .offset(x: screenWidth*shopItemsOffset)
                            .mask(
                                Rectangle()
                                    .frame(width: screenWidth*0.77, height: screenWidth*0.29)
                            )
                        
                            .offset( y: screenWidth*0.06)
                    )
                Image("selectEvel")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.09)
                    .offset(x: screenWidth*0.075, y: -screenWidth*0.13)
                    .onTapGesture {
                        changeShopSet()
                    }
            }
            if shopSet == 2 {
                Image("shopEvelFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.8)
                    .offset(y: screenWidth*0.02)
                    .overlay(
                        ZStack {
                            HStack(spacing: screenWidth*0.04) {
                                ForEach(0..<3, id: \.self) {item in
                                    ZStack {
                                        Image("shopItemFrame")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.2)
                                        Image(shopItemsEvelArray[item].itemName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: screenWidth*0.1, maxHeight: screenWidth*0.18)
                                        if shopItemsEvelData[item] == 2 {
                                            Image("selectedShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.06)
                                                .offset(y: screenWidth*0.11)
                                        }
                                        if shopItemsEvelData[item] == 1 {
                                            Image("selectShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.086)
                                                .offset(y: screenWidth*0.11)
                                                .onTapGesture {
                                                    selectEvelWarrior(item: item)
                                                }
                                        }
                                        if shopItemsEvelData[item] == 0 {
                                            if coinCount >= shopItemsEvelArray[item].cost {
                                                Image("greenShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsEvelArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                                    .onTapGesture {
                                                        buyEvelWarrior(item: item)
                                                    }
                                            } else {
                                                Image("redShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsEvelArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                            }
                                        }
                                    }
                                }
                            }
                            .offset(x: -screenWidth*0.363)
                            HStack(spacing: screenWidth*0.04) {
                                ForEach(3..<6, id: \.self) {item in
                                    ZStack {
                                        Image("shopItemFrame")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.2)
                                        Image(shopItemsEvelArray[item].itemName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: screenWidth*0.1, maxHeight: screenWidth*0.18)
                                        if shopItemsEvelData[item] == 2 {
                                            Image("selectedShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.06)
                                                .offset(y: screenWidth*0.11)
                                        }
                                        if shopItemsEvelData[item] == 1 {
                                            Image("selectShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.086)
                                                .offset(y: screenWidth*0.11)
                                                .onTapGesture {
                                                    selectEvelWarrior(item: item)
                                                }
                                        }
                                        if shopItemsEvelData[item] == 0 {
                                            if coinCount >= shopItemsEvelArray[item].cost {
                                                Image("greenShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsEvelArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                                    .onTapGesture {
                                                        buyEvelWarrior(item: item)
                                                    }
                                            } else {
                                                Image("redShopFrame")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.086)
                                                    .overlay(
                                                        Text("\(shopItemsEvelArray[item].cost)")
                                                            .font(Font.custom("CrushYourEnemies", size: screenWidth*0.018))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                    )
                                                    .offset(y: screenWidth*0.11)
                                            }
                                        }
                                    }
                                }
                            }
                            .offset(x: screenWidth*0.363)
                        }
                            .offset(x: screenWidth*shopItemsOffset)
                            .mask(
                                Rectangle()
                                    .frame(width: screenWidth*0.77, height: screenWidth*0.29)
                            )
                        
                            .offset( y: screenWidth*0.06)
                    )
                Image("selectGood")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.09)
                    .offset(x: -screenWidth*0.085, y: -screenWidth*0.13)
                    .onTapGesture {
                        changeShopSet()
                    }
            }
            HStack(spacing: screenWidth*0.65) {
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        changeItemOffsetLeft()
                    }
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .scaleEffect(x: -1)
                    .onTapGesture {
                        changeItemOffsetLeft()
                    }
            }
            .offset(y: screenWidth*0.06)
            HStack {
                Image("homeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.1)
                    .onTapGesture {
                        coordinator.navigate(to: .mainMenu)
                        
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
        }
    }
    
    func buyGoodWarrior(item: Int) {
        coinCount -= shopItemsGoodArray[item].cost
        shopItemsGoodData[item] = 1
        UserDefaults.standard.set(shopItemsGoodData, forKey: "shopItemsGoodData")
    }
    
    func selectGoodWarrior(item: Int) {
        for i in 0..<shopItemsGoodData.count {
            if shopItemsGoodData[i] == 2 {
                shopItemsGoodData[i] = 1
            }
        }
        shopItemsGoodData[item] = 2
        UserDefaults.standard.set(shopItemsGoodData, forKey: "shopItemsGoodData")
        yourCommandorNumber = item
    }
    
    func buyEvelWarrior(item: Int) {
        coinCount -= shopItemsEvelArray[item].cost
        shopItemsEvelData[item] = 1
        UserDefaults.standard.set(shopItemsEvelData, forKey: "shopItemsEvelData")
    }
    
    func selectEvelWarrior(item: Int) {
        for i in 0..<shopItemsEvelData.count {
            if shopItemsEvelData[i] == 2 {
                shopItemsEvelData[i] = 1
            }
        }
        shopItemsEvelData[item] = 2
        UserDefaults.standard.set(shopItemsEvelData, forKey: "shopItemsEvelData")
        enemyCommandorNumber = item
    }
    
    func changeItemOffsetLeft() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            shopItemsOffset *= -1
        }
    }
    
    func changeShopSet() {
        if shopSet == 1 {
            withAnimation() {
                shopSet = 2
            }
        } else {
            withAnimation() {
                shopSet = 1
            }
        }
    }
    
}

#Preview {
    Shop()
}
