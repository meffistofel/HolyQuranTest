//
//  ContinueRow.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

enum LastPrayerAction: CaseIterable {
    case reading
    case recitation

    var title: String {
        switch self {
        case .reading:
            return "Continue reading"
        case .recitation:
            return  "Continue recitation"
        }
    }

    var image: String {
        switch self {
        case .reading:
            return Constants.Image.iconReading
        case .recitation:
            return Constants.Image.iconListening
        }
    }
}

struct ContinueRow: View {

    let type: LastPrayerAction

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Label {
                    Text(type.title)
                        .customFont(.medium, size: 12)
                        .foregroundColor(Color.gray)
                } icon: {
                    Image(type.image)
                }


                Text("Al-Fatiah")
                    .customFont(.semibold, size: 16)
                    .padding(.leading, 4)
                Text("Ayah No: 1")
                    .customFont(.regular, size: 14)
                    .padding(.leading, 4)
            }

            Spacer()
        }
        .padding(.leading, 8)
        .padding([.top, .bottom], 16)
        .background(RoundedRectangle(cornerRadius: 8)
        .stroke(Color.gray, lineWidth: 1))
    }
}

struct ContinueRow_Previews: PreviewProvider {
    static var previews: some View {
        ContinueRow(type: .reading)
    }
}
