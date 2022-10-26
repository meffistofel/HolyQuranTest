//
//  CustomSegmented.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 31.08.2022.
//

import SwiftUI

struct CustomPickerView: View {

    @Binding var selection: PickerSelectionState
    var segments: [PickerSelectionState]
    var color: [Color]
    var spacing: CGFloat = 0

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(segments, id: \.self) { segment in
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .cornerRadius(spacing > 0 ? 8 : 0)

                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: color), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(8)
                        .opacity(selection == segment ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                selection = segment
                            }
                        }
                }
                .overlay(
                    CustomText(text: segment.title, font: (.medium, 16), foregroundColor: selection == segment ? .white : Color.black)
                )
            }
        }
        .frame(height: 36)
        .cornerRadius(8)
    }
}

#if DEBUG
struct CustomPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPickerView(selection: .constant(.surah), segments: [.surah, .juz], color: [.blue], spacing: 16)
    }
}
#endif
