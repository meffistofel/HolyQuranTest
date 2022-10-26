//
//  TruncableText.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

struct TruncableText: View {

    // MARK: - Wrapped Properties

    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero

    // MARK: - Properties

    let text: Text
    var lineLimit: Int? = nil
    let isTruncatedUpdate: (_ isTruncated: Bool) -> Void

    // MARK: - body View

    var body: some View {
        text
            .lineLimit(lineLimit)
            .readSize { size in
                truncatedSize = size
                isTruncatedUpdate(truncatedSize != intrinsicSize)
            }
            .background(
                text
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                        isTruncatedUpdate(truncatedSize != intrinsicSize)
                    }
            )
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
