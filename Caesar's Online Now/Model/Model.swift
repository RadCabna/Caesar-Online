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
}

struct Warrior: Equatable {
    var itemName: String
   var opacity: CGFloat = 1
    var shadowScale: CGFloat = 1
}

class Arrays {
    
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
