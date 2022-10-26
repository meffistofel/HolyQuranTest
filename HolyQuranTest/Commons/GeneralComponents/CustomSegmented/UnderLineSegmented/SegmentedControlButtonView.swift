//
//  UnderLineSegmented.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//

import SwiftUI

struct SegmentedControlButtonView: View {
    @Binding private var selectedIndex: Int
    @Binding private var frames: [CGRect]
    @Binding private var backgroundFrame: CGRect
    @Binding private var isScrollable: Bool

    private let segments: [PickerSelectionState]

    let checkIsScrollable: (() -> Void)

    init(selectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, isScrollable: Binding<Bool>, checkIsScrollable: (@escaping () -> Void), segments: [PickerSelectionState]) {
        _selectedIndex = selectedIndex
        _frames = frames
        _backgroundFrame = backgroundFrame
        _isScrollable = isScrollable

        self.checkIsScrollable = checkIsScrollable
        self.segments = segments
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments.indices, id: \.self) { index in
                Button {
                    selectedIndex = index
                } label: {
                        Text(segments[index].title)
                            .customFont(index == selectedIndex ? .semibold : .medium, size: 16)
                            .foregroundColor(index == selectedIndex ? .black : .gray)
                            .frame(maxWidth: .infinity)
                }
                .buttonStyle(CustomSegmentButtonStyle())
                .background(
                    GeometryReader { geoReader in
                        Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                            .onPreferenceChange(RectPreferenceKey.self) {
                                self.setFrame(index: index, frame: $0)
                            }
                    }
                )
            }
        }
        .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames))
    }

    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame

        checkIsScrollable()
    }
}

struct CustomSegmentButtonStyle: ButtonStyle {
   func makeBody(configuration: Self.Configuration) -> some View {
       configuration
           .label
           .padding(EdgeInsets(top: 14, leading: 12, bottom: 16, trailing: 12))
           .background(Color.clear)
   }
}

struct UnderlineModifier: ViewModifier {
   var selectedIndex: Int
   let frames: [CGRect]

   func body(content: Content) -> some View {
       content
           .background(
               Rectangle()
                   .fill(Color.black)
                   .frame(width: frames[selectedIndex].width, height: 3)
                   .offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .bottomLeading
           )
           .background(
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 3), alignment: .bottomLeading
           )
           .animation(.default, value: selectedIndex)
   }
}

struct RectPreferenceKey: PreferenceKey {
   typealias Value = CGRect

   static var defaultValue = CGRect.zero

   static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
       value = nextValue()
   }
}

