//
//  Model.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 11.06.2025.
//

import Foundation

struct Tent: Equatable {
    var itemName: String
    var positionX: CGFloat
    var positionY: CGFloat
    var tentPosition: Int
   var shadowRadius: CGFloat = 0
    var couldSelect: Bool = false
    var haveHelmet = false
    var boomStart = false
    var smokeStart = false
    var crashed = false
}

struct Warrior: Equatable {
    var itemName: String
   var opacity: CGFloat = 1
    var shadowScale: CGFloat = 1
}

struct Solder: Equatable {
    var itemName: String
    var opacity: CGFloat = 1
    var positionX: CGFloat
    var positionY: CGFloat
}

struct Ammunition: Equatable {
    var itemName: String
    var opacity: CGFloat = 0
    var positionX: CGFloat
    var positionY: CGFloat
    var angle: CGFloat = 105
}

struct BonusTent: Equatable {
    var itemName: String = "purpleTent"
    var yOffset: CGFloat = 0
    var tentShadowScale: CGFloat = 1
}

struct ShopItem: Equatable {
    var itemName: String
    var cost: Int
}

class Arrays {
    
    static var shopItemsGoodArray = [
        ShopItem(itemName: "goodKnight1", cost: 1),
        ShopItem(itemName: "goodKnight2", cost: 300),
        ShopItem(itemName: "goodKnight3", cost: 400),
        ShopItem(itemName: "goodKnight4", cost: 500),
        ShopItem(itemName: "goodKnight5", cost: 700),
        ShopItem(itemName: "goodKnight6", cost: 900)
    ]
    
    static var shopItemsEvelArray = [
        ShopItem(itemName: "evilKnight1", cost: 1),
        ShopItem(itemName: "evilKnight2", cost: 300),
        ShopItem(itemName: "evilKnight3", cost: 400),
        ShopItem(itemName: "evilKnight4", cost: 500),
        ShopItem(itemName: "evilKnight5", cost: 700),
        ShopItem(itemName: "evilKnight6", cost: 900)
    ]
    
    static var bonusTentArray: [BonusTent] = [
        BonusTent(),
        BonusTent(),
        BonusTent(),
        BonusTent(),
        BonusTent()
        ]
    
    static var rulesArray = ["rule1", "rule2", "rule3"]
    
    static var levelOffsetsArray = [-0.05,0.05,-0.05,0.05,-0.05,0.05]
    
    static var boomImagesArray = ["spriteBoom1", "spriteBoom2", "spriteBoom3", "spriteBoom4", "spriteBoom5", "spriteBoom6", "spriteBoom7"]
    
    static var smokeImageArray = ["smokeSprite1", "smokeSprite2", "smokeSprite3", "smokeSprite4", "smokeSprite5", "smokeSprite6", "smokeSprite7", "smokeSprite8"]
    
    static var ammunitionArray: [Ammunition] = [
        Ammunition(itemName: "arrow", positionX: 0, positionY: 0),
        Ammunition(itemName: "ball", positionX: 0, positionY: 0, angle: 285),
        Ammunition(itemName: "spear", positionX: 0, positionY: 0)
    ]
    
    static var yourSolder: Solder = Solder(itemName: "yourHelmet", positionX: -370, positionY: 100)
    static var enemySolder: Solder = Solder(itemName: "enemyHelmet", positionX: 370, positionY: 100)
    
    static var warriorArray: [Warrior] = [
        Warrior(itemName: "arrowWarrior"),
        Warrior(itemName: "flameBallWarrior"),
        Warrior(itemName: "spearWarrior"),
    ]
    
    static var redTensArray: [Tent] = [
        Tent(itemName: "redTent", positionX: -197, positionY: -30, tentPosition: 1),
        Tent(itemName: "redTent", positionX: -243, positionY: 3, tentPosition: 2),
        Tent(itemName: "redTent", positionX: -278, positionY: 42, tentPosition: 3),
        Tent(itemName: "redTent", positionX: -307, positionY: 93, tentPosition: 4),
        Tent(itemName: "redTent", positionX: -326, positionY: 153, tentPosition: 5),
        Tent(itemName: "redTent", positionX: -150, positionY: 7, tentPosition: 6),
        Tent(itemName: "redTent", positionX: -192, positionY: 45, tentPosition: 7),
        Tent(itemName: "redTent", positionX: -224, positionY: 91, tentPosition: 8),
        Tent(itemName: "redTent", positionX: -244, positionY: 149, tentPosition: 9),
        Tent(itemName: "redTent", positionX: -106, positionY: 49, tentPosition: 10),
        Tent(itemName: "redTent", positionX: -147, positionY: 93, tentPosition: 11),
        Tent(itemName: "redTent", positionX: -169, positionY: 150, tentPosition: 12),
        Tent(itemName: "redTent", positionX: -63, positionY: 93, tentPosition: 13),
        Tent(itemName: "redTent", positionX: -97, positionY: 145, tentPosition: 14)
    ]
    
    static var blueTensArray: [Tent] = [
        Tent(itemName: "blueTent", positionX: 197, positionY: -30, tentPosition: 1),
        Tent(itemName: "blueTent", positionX: 243, positionY: 3, tentPosition: 2),
        Tent(itemName: "blueTent", positionX: 278, positionY: 42, tentPosition: 3),
        Tent(itemName: "blueTent", positionX: 307, positionY: 93, tentPosition: 4),
        Tent(itemName: "blueTent", positionX: 326, positionY: 153, tentPosition: 5),
        Tent(itemName: "blueTent", positionX: 150, positionY: 7, tentPosition: 6),
        Tent(itemName: "blueTent", positionX: 192, positionY: 45, tentPosition: 7),
        Tent(itemName: "blueTent", positionX: 224, positionY: 91, tentPosition: 8),
        Tent(itemName: "blueTent", positionX: 244, positionY: 149, tentPosition: 9),
        Tent(itemName: "blueTent", positionX: 106, positionY: 49, tentPosition: 10),
        Tent(itemName: "blueTent", positionX: 147, positionY: 93, tentPosition: 11),
        Tent(itemName: "blueTent", positionX: 169, positionY: 150, tentPosition: 12),
        Tent(itemName: "blueTent", positionX: 63, positionY: 93, tentPosition: 13),
        Tent(itemName: "blueTent", positionX: 97, positionY: 145, tentPosition: 14)
    ]
}
