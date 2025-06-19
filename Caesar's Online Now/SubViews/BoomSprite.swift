//
//  BoomSprite.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 15.06.2025.
//

import SwiftUI

struct BoomSprite: View {
    @State private var boomImagesArray = Arrays.boomImagesArray
    @State private var imageIndex: Int = 0
    @State private var imageOpacity: CGFloat = 0
    var startBoom: Bool = false
    var body: some View {
       Image(boomImagesArray[imageIndex])
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth*0.1)
            .opacity(imageOpacity)
            .onChange(of: startBoom) { _ in
                imageIndex = 0
                imageOpacity = 0
                boomAnimation()
            }
    }
    
    func boomAnimation() {
        var delay: Double = 0.1
        imageOpacity = 1
        for _ in 0..<boomImagesArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if imageIndex < 6 {
                    imageIndex += 1
                }
                
            }
            delay += 0.1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 0.6)) {
                imageOpacity = 0
            }
        }
    }
    
}

#Preview {
    BoomSprite()
}
