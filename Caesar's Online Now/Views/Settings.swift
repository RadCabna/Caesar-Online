//
//  Settings.swift
//  Caesar's Online Now
//
//  Created by Алкександр Степанов on 09.06.2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @AppStorage("vibration") var vibration = true
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
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.35)
                .overlay(
                    ZStack {
                        VStack {
                            HStack(spacing: screenWidth*0.03) {
                                Image(sound ? "soundOn" : "soundOff")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.07)
                                Toggle("", isOn: $sound)
                                    .toggleStyle(CustomToggle(text: .constant("SOUND")))
                            }
                            .frame(minHeight: screenWidth*0.075)
                            HStack(spacing: screenWidth*0.03) {
                                Image(music ? "musicOn" : "musicOff")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.07)
                                Toggle("", isOn: $music)
                                    .toggleStyle(CustomToggle(text: .constant("MUSIC")))
                            }
                            .frame(minHeight: screenWidth*0.075)
                            HStack(spacing: screenWidth*0.03) {
                                Image(vibration ? "vibrationOn" : "vibrationOff")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.07)
                                Toggle("", isOn: $vibration)
                                    .toggleStyle(CustomToggle(text: .constant("VIBRATION")))
                            }
                            .frame(maxWidth: screenWidth*0.22, minHeight: screenWidth*0.075)
                        }
                        .offset(y: screenWidth*0.03)
                        Image("rateUsButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.08)
                            .offset(y: screenWidth*0.19)
                            .onTapGesture {
                                openAppStoreForRating()
                            }
                    }
                )
        }
        
        .onChange(of: music) { _ in
            if !music {
                SoundManager.instance.stopAllSounds()
            } else {
                SoundManager.instance.playSound(sound: "musicMain")
            }
        }
        
    }
    
    func openAppStoreForRating() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id6747492687?action=write-review") else {
            return
        }
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
}

#Preview {
    Settings()
}

struct CustomToggle: ToggleStyle {
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    @Binding var text: String
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            VStack {
                Text(text)
                    .font(Font.custom("CrushYourEnemies", size: screenWidth*0.012))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2)
               Image("toggleBack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.08)
            }
                .overlay(
                    ZStack {
                        Image("toggle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.05)
                            .offset(y: screenWidth*0.007)
                            .offset(x: configuration.isOn ? screenWidth*0.02 : -screenWidth*0.02)
                            .animation(.easeInOut, value: configuration.isOn)
                    }
                )
        }
    }
}
