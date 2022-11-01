//
//  Disabled+Opacity.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 30.10.2022.
//

import SwiftUI

struct DisableWithOpacity: ViewModifier {
    
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(!isVisible)
            .opacity(isVisible ? 1 : 0.4)
    }
}

extension View {
    func disabled(_ isVisible: Binding<Bool>) -> some View {
        modifier(DisableWithOpacity(isVisible: isVisible))
    }
}
