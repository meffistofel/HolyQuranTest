//
//  EntryField.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI
import Combine

struct InputTextField: View {

    @Binding var text: String
    @State var isSecure: Bool = false
    @State private var textFieldState: TextFieldState = .normal

    var inputType: InputType
    var closure: EmptyClosure?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            promtTextField
                .padding(.bottom, 6)
            textFieldView
                .onTapGesture {
                    if !isSecurityState && inputType.disabled {
                        closure?()
                    }
                }
            errorLabel
                .padding(.horizontal, 12)
        }
    }

    private var isSecurityState: Bool {
        false
//        inputType == .password || inputType == .confirmPassword
    }

    private func setTextFieldState() -> TextFieldState {
       print("setTextFieldState \(text)")

        if text.isEmpty {
            return .normal
        }

        return inputType.isValid(with: text) ? .valid : .error
    }
}

// MARK: - ViewBuilder View

private extension InputTextField {

    @ViewBuilder
    var promtTextField: some View {
        Text("\(inputType.prompt)")
            .customFont(.medium, size: 12)
            .foregroundColor(textFieldState.style.promtColor)
            .fixedSize(horizontal: false, vertical: true)
            .animation(.linear(duration: 0.1), value: textFieldState)
    }

    @ViewBuilder
    var textFieldView: some View {
        HStack {
            ZStack(alignment: .leading) {

                //placholder
                if text.isEmpty {
                    Text("\(inputType.placeholder)")
                        .customFont(.regular, size: 16)
                        .foregroundColor(.gray)
                }
                textField
                    .autocapitalization(inputType.capitalization)
                    .keyboardType(inputType.keyboardType)
                    .disabled(inputType.disabled)

            }
            rightImage
                .disabled(inputType.disabled)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background(inputType.backgroundColor)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8)
            .strokeBorder(textFieldState.style.borderColor, lineWidth: textFieldState.style.borderWidth)
        )
        .animation(.linear(duration: 0.1), value: textFieldState)

    }

    @ViewBuilder
    var textField: some View {
        if isSecurityState {
            CustomSecureTF(text: $text, isSecure: isSecure) { isEdited in
                if !isEdited {
                    textFieldState = setTextFieldState()
                } else {
                    textFieldState = .editing
                }
            }
            .frame(height: 0)

        } else {
            TextField("", text: $text) { isEdited in
                if !isEdited {
                    textFieldState = setTextFieldState()
                } else {
                    textFieldState = .editing
                }
            }
        }
    }

    @ViewBuilder
    var rightImage: some View {
        if !inputType.getImage().isEmpty || textFieldState == .error {
            Button {
                if isSecurityState {
                    isSecure.toggle()
                }
            } label: {
                if isSecurityState {
                    Image(inputType.getImage(isSecure: isSecure))
                        .animation(.linear(duration: 0.1), value: textFieldState)
                } else {
                    Image(textFieldState == .error ? inputType.errorImage : inputType.getImage())
                        .animation(.linear(duration: 0.1), value: textFieldState)
                }
            }
        }
    }

    @ViewBuilder
    var errorLabel: some View {
        Text("\(textFieldState == .error ? inputType.errorMessage : inputType.errorMessage.isEmpty ? "" : " ")")
            .customFont(.medium, size: 12)
            .foregroundColor(.red)
            .animation(.linear(duration: 0.1), value: textFieldState)
    }
}
