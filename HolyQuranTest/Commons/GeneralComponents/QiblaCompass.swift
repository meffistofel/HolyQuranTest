//
//  QiblaCompass.swift
//  WatchHolyQuran WatchKit Extension
//
//  Created by Oleksand Kovalov on 21.04.2022.
//  Copyright © 2022 GRT-Team. All rights reserved.
//

import SwiftUI

// MARK: - QiblaCompass

struct QiblaCompass: View {

    // MARK: - Wrapped Properties

    @State private var isNeedAnimation: Bool = false

    // MARK: - Properties

    var degrees: Double
    var compassDegrees: Double

    // MARK: - body View

    var body: some View {
        GeometryReader { geo in
        Image("image_compass")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width, height: geo.size.height)
            .overlay(QiblaDirection()
                .fill(Color.qiblaDirection)
                .opacity(0.8)
                .overlay(QiblaDirection()
                    .stroke(Color.qiblaDirection, lineWidth: 2)
                    .opacity(0.8))
                .rotationEffect(SwiftUI.Angle(degrees: degrees)))
                .overlay(Image("qibla")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .rotationEffect(SwiftUI.Angle(degrees: -30))
                    .offset(x: 0, y: -geo.size.height / 2)
                    .rotationEffect(SwiftUI.Angle(degrees: degrees)))
                .rotationEffect(SwiftUI.Angle(degrees: compassDegrees))
                .animation(isNeedAnimation ? .easeIn : nil, value: compassDegrees)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isNeedAnimation = true
                    }
                }
        }
    }
}

// MARK: - QiblaDirection

struct QiblaDirection: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.midX, y: rect.midY - 15))
            path.addLine(to: .init(x: rect.midX, y: rect.minY))
            path.addArc(center: .init(x: rect.midX, y: rect.minY), radius: 12, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
            path.addLine(to: .init(x: rect.midX, y: rect.minY))
            path.closeSubpath()
        }
    }
}

// MARK: - Previews

struct QiblaCompass_Previews: PreviewProvider {
    static var previews: some View {
        QiblaCompass(degrees: 40, compassDegrees: 40)
    }
}
