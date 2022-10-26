//
//  ErrorView.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import Foundation
import SwiftUI

struct ErrorView: View {

    // MARK: - Properties

    let error: Error
    let retryAction: () -> Void

    // MARK: - body View

    var body: some View {
        VStack {
            Text("An Error Occured")
                .font(.title)
            Text(setCorrectError(error: error))
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40).padding()
            Button(action: retryAction, label: { Text("Retry").bold() })
        }
    }

    // MARK: - Methods

    func setCorrectError(error: Error) -> String {
        if let apiError = error as? APIError {
            return apiError.errorDescription ?? ""
        } else {
            return error.localizedDescription
        }
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: NSError(domain: "", code: 0, userInfo: [
            NSLocalizedDescriptionKey: "Something went wrong"]),
                  retryAction: { })
    }
}
#endif
