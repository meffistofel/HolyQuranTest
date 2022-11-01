//
//  SegmentedControlView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

struct SegmentedControlView: View {
    @Binding private var selectedIndex: Int

    @State private var frames: Array<CGRect>
    @State private var backgroundFrame = CGRect.zero
    @State private var isScrollable = true

    private let segments: [PickerSelectionState]
    private let isNeedUnderLine: Bool

    init(
        selectedIndex: Binding<Int>,
        segments: [PickerSelectionState],
        isNeedUnderLine: Bool = true
    ) {
        self._selectedIndex = selectedIndex
        self.segments = segments
        self.isNeedUnderLine = isNeedUnderLine
        frames = Array<CGRect>(repeating: .zero, count: segments.count)
    }

    var body: some View {
        VStack {
            if isScrollable {
                ScrollView(.horizontal, showsIndicators: false) {
                    SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, segments: segments, isNeedUnderLine: isNeedUnderLine)
                }
            } else {
                SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, segments: segments, isNeedUnderLine: isNeedUnderLine)
            }
        }
        .background(
            GeometryReader { geoReader in
                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                    .onPreferenceChange(RectPreferenceKey.self) {
                    self.setBackgroundFrame(frame: $0)
                }
            }
        )
    }

    private func setBackgroundFrame(frame: CGRect) {
        backgroundFrame = frame
        checkIsScrollable()
    }

    private func checkIsScrollable() {
        if frames[frames.count - 1].width > .zero {
            var width = CGFloat.zero

            for frame in frames {
                width += frame.width
            }

            if isScrollable && width <= backgroundFrame.width {
                isScrollable = false
            }
            else if !isScrollable && width > backgroundFrame.width {
                isScrollable = true
            }
        }
    }
}
