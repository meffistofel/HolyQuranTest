//
//  CustomAlert.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 22.10.2022.
//

import SwiftUI

struct AlertModifier: ViewModifier {

    @Binding var showAlert: Bool

    let title: String
    let message: String
    var primaryButton: Alert.Button
    var secondaryButton: Alert.Button

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            }
    }
}

extension View {
    func showAlert(
        showAlert: Binding<Bool>,
        title: String = "",
        message: String = "",
        primaryButton: Alert.Button,
        secondaryButton: Alert.Button
    ) -> some View {
        modifier(AlertModifier(
            showAlert: showAlert,
            title: title,
            message: message,
            primaryButton: primaryButton,
            secondaryButton: secondaryButton
        ))
    }
}
