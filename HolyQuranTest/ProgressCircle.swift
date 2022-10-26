//
//  ProgressCircle.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 5)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: Color.gradient),
                        center: .center
                    ),
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
            
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeOut, value: progress)

            VStack {
                Circle()
                    .fill(Color.endGradient)
                    .frame(width: 11, height: 11)
                    .overlay {
                        Circle()
                            .stroke(Color.white, lineWidth: 1.5)
                    }
                    .offset(y: -5)

                Spacer()
            }

        }

    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0)
    }
}
