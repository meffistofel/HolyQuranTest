//
//  SwiperView.swift
//  PageViewer
//
//  Created by Grzegorz Przybyła on 20/12/2019.
//  Copyright © 2019 Grzegorz Przybyła. All rights reserved.
//

import SwiftUI

struct SwiperView: View {
    let pages: [PageViewData]
    
    @Binding var index: Int
    @State private var offset: CGFloat = 0
    @State private var isUserSwiping: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                scrollHeader(geometry: geometry)
                bottomSheetText
                    .padding(.top, 40)
                    .padding(.horizontal, 32)
                Spacer()
                pageControl
                    .padding(.bottom, 80)
            }
        }
    }
}

private extension SwiperView {
    @ViewBuilder
    func scrollHeader(geometry: GeometryProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.pages) { viewData in
                        PageView(viewData: viewData)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.56)

                    }
                }
            }
        }
        .content
        .offset(x: self.isUserSwiping ? self.offset : CGFloat(self.index) * -geometry.size.width)
        .frame(width: geometry.size.width, alignment: .leading)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    self.isUserSwiping = true
                    self.offset = value.translation.width + -geometry.size.width * CGFloat(self.index)
                })
                .onEnded({ value in
                    if value.predictedEndTranslation.width < geometry.size.width / 2, self.index < self.pages.count - 1 {
                        self.index += 1
                    }
                    if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                        self.index -= 1
                    }
                    withAnimation {
                        self.isUserSwiping = false
                    }
                })
        )
    }

    @ViewBuilder
    var bottomSheetText: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Read Quran")
                .customFont(.semibold, size: 24)
                .padding(.bottom, 16)
            Text(pages[index].text)
                .customFont(.regular, size: 14)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }

    @ViewBuilder
    var pageControl: some View {
        HStack(spacing: 62) {
            
            Button {
                withAnimation {
                    self.index -= 1
                }
            } label: {
                Image("image_arrow_button")
            }.if(self.index == 0) { $0.hidden() }

            HStack(spacing: 8) {
                ForEach(0..<self.pages.count) { index in
                    CircleButton(isSelected: Binding<Bool>(get: { self.index == index }, set: { _ in })) {
                        withAnimation {
                            self.index = index
                        }
                    }
                }
            }

            Button {
                withAnimation {
                    self.index += 1
                }
            } label: {
                Image("image_arrow_button")
                    .rotationEffect(.init(degrees: 180))
            }.if(self.index == pages.count - 1) { $0.hidden() }
        }
    }
}

