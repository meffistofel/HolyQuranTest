//
//  RadioButtonGroup.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 12.10.2022.
//

import SwiftUI

enum RadioButtonType {
    case radio
    case radioWithImage
    case checkmark
    case none

    func image(isSelected: Bool) -> String {
        switch self {
        case .radio, .radioWithImage:
            return isSelected ? "largecircle.fill.circle" : "circle"
        case .checkmark:
            return isSelected ? "checkmark.square" : "square"
        case .none:
            return ""
        }
    }
}

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let type: RadioButtonType
    let id: String
    let callback: ValueClosure<String>
    let selectedID : String
    let size: CGFloat
    let color: Color


    init(
        type: RadioButtonType,
        _ id: String,
        callback: @escaping ValueClosure<String>,
        selectedID: String,
        size: CGFloat = 24,
        color: Color = Color.primary
    ) {
        self.type = type
        self.id = id
        self.size = size
        self.color = color
        self.selectedID = selectedID
        self.callback = callback
    }

    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {

                Image(systemName: type.image(isSelected: selectedID == id))
                    .customListImage()
                if type == .radioWithImage {
                    Label(id, image: "")
                } else {
                    CustomText(text: id, font: (.regular, 16), foregroundColor: selectedID == id ? .orange : .gray)
                }

                Spacer()
            }
        }
        .foregroundColor(selectedID == id ? .orange : .gray)
    }
}

struct RadioButtonGroup: View {

    let type: RadioButtonType
    let items : [String]

    @State var selectedId: String = ""

    let callback: ValueClosure<String>

    var body: some View {
        VStack(spacing: 0) {
            ForEach(items.indices) { index in
                RadioButton(type: type, self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedId)
                    .padding(.vertical, 14)
                Divider()
            }
        }
    }

    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

//#if DEBUG
//struct RadioButton_Previews: PreviewProvider {
//    static var id = UUID().uuidString
//
//    static var previews: some View {
//        NavigationView {
//            RadioButton(type: .checkmark, id , callback: { _ in }, selectedID: id, size: 20, color: .black)
//        }
//    }
//}
//#endif
