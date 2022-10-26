//
//  CustomTextField.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 07.10.2022.
//

import SwiftUI

var onChangeClosure: ValueClosure<String>?

final class _TextFieldCoordinator: NSObject, UITextFieldDelegate {

    var control: CustomSecureTF
    var isSecure: Bool

    init(_ control: CustomSecureTF, _ isSecure: Bool) {
        self.control = control
        self.isSecure = isSecure
        super.init()

        bind()
    }

    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
        control.text = textField.text ?? ""
        control.onEditingChanged(true)
    }

    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        control.text = textField.text ?? ""
        control.onEditingChanged(false)
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        onChangeClosure?(textField.text ?? "")
    }

    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        control.onCommit()
    }

    @objc func updateText(sender: UITextField) {
        control.text = sender.text ?? ""
    }

    private func bind() {
        control.textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        control.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)

    }
}

struct CustomSecureTF: UIViewRepresentable {

    @Binding var text: String

    var isSecure: Bool
    let onEditingChanged: ValueClosure<Bool>
    let onCommit: EmptyClosure

    let textField = UITextField()

    init(
        text: Binding<String>,
        isSecure: Bool,
        onEditingChanged: @escaping ValueClosure<Bool> = { _ in },
        onCommit: @escaping EmptyClosure = {}
    ) {
        self._text = text
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.isSecure = isSecure
    }


    func makeCoordinator() -> _TextFieldCoordinator {
        _TextFieldCoordinator(self, isSecure)
    }

    func makeUIView(context: Context) -> UITextField {
        textField.isSecureTextEntry = isSecure
        textField.delegate = context.coordinator


        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.isSecureTextEntry = isSecure
        uiView.text = text

        onChangeClosure = { text in
            self.text = text
        }
    }
}
