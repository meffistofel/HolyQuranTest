//
//  PrayerRow.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

struct PrayerRow: View {
    var body: some View {
        VStack {
            HStack {
                Text("1")
                    .customFont(.medium, size: 14)
                    .padding(.trailing, 31)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Al-Fatiah")
                        .customFont(.medium, size: 16)
                    Text("Meccan • 7 verses")
                }

                Spacer()

                Text("ةحتافلا")
                    .customFont(.bold, size: 20)
            }
            .padding(.leading, 16)

            Rectangle()
                .fill(Color.gray.opacity(0.7))
                .frame(height: 1)
        }
    }
}

struct PrayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerRow()
    }
}
