//
//  SearchBar.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false

    var body: some View {
        HStack {

            TextField("Tel-Aviv, Israel", text: $text)
                .padding(.vertical, 16)
                .padding(.horizontal, 41)
                .background(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(Constants.Image.iconCurrentLocation)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)

                        if isEditing {
                            Button {
                                self.text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {
                Button {
                    self.isEditing = false
                    self.text = ""

                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
