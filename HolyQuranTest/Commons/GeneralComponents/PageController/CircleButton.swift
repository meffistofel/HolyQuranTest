//
//  CircleButton.swift
//  PageViewer
//
//  Created by Grzegorz Przybyła on 20/12/2019.
//  Copyright © 2019 Grzegorz Przybyła. All rights reserved.
//

import SwiftUI

struct CircleButton: View {
    @Binding var isSelected: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Circle()
                .frame(width: isSelected ? 10 : 6, height: isSelected ? 10 : 6)
                .foregroundColor(isSelected ? Color.gray : Color.gray.opacity(0.5))
        }
    }
}
