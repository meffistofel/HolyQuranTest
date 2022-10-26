//
//  SplashScreen.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

struct SplashScreen: View {
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        Image(Constants.Image.imageSplashLogo)
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 0.9
                    self.opacity = 1.00
                }
            }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
