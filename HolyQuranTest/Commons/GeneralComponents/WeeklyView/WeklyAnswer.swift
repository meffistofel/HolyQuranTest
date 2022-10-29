//
//  WeklyAnswer.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 29.10.2022.
//

import SwiftUI

struct WeeklyAnswerView: View {
    let text: String
    
    var body: some View {
        ContentWithSpacer(contentAlignment: .leading) {
            ContentWithSpacer(contentAlignment: .leading) {
                Text(text)
                    .customFont(.medium, size: 14)
            }
            .frame(width: 134, height: 50)
            .padding(.leading, 16)
            .addShadowToRectangle(color: .gray.opacity(0.4), radius: 3, cornerRadius: 7)
        }
    }
}
