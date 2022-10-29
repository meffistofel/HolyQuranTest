//
//  WeeklyQuestion.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 29.10.2022.
//

import SwiftUI

struct WeeklyQuestionView<Content: View>: View {
    
    private let text: String
    private let content: Content
    private let spacing: CGFloat
    
    init(
        text: String,
        spacing: CGFloat = 24,
        @ViewBuilder content: () -> Content
    ) {
        self.text = text
        self.spacing = spacing
        self.content = content()
    }
   
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(text)
                .customFont(.medium, size: 16)
                .foregroundColor(.gray)
            content
        }
    }
}
