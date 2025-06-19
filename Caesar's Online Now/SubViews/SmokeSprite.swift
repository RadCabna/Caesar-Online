//
//  SmokeSprite.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 18.06.2025.
//

import SwiftUI

struct SmokeSprite: View {
    @State private var smokeImagesArray = Arrays.smokeImageArray
    @State private var imageIndex: Int = 0
    @State private var imageOpacity: CGFloat = 0
    var startSmoke: Bool = false
    var body: some View {
        Image(smokeImagesArray[imageIndex])
             .resizable()
             .scaledToFit()
             .frame(width: screenWidth*0.25)
             .opacity(imageOpacity)
             .onChange(of: startSmoke) { _ in
                 imageIndex = 0
                 imageOpacity = 0
                 smokeAnimation()
             }
//             .onAppear {
//                 smokeAnimation()
//             }
    }
    
    func smokeAnimation() {
        var delay: Double = 0.1
        imageOpacity = 1
        for _ in 0..<smokeImagesArray.count {
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
    SmokeSprite()
}
