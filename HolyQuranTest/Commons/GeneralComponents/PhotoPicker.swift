//
//  PhotoPicker.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 22.10.2022.
//

import SwiftUI
import PhotosUI



struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController

    let filter: PHPickerFilter
    var limit: Int = 0 // 0 == 'no limit'.
    let onComplete: ([PHPickerResult]) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = filter
        configuration.selectionLimit = limit
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {

        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.onComplete(results)
            picker.dismiss(animated: true)
        }
    }

    static func convertToUIImageArray<T: NSItemProviderReading>(fromResults results: [PHPickerResult], onComplete: @escaping ([T]?, Error?) -> Void) {
        var images = [T]()

        let dispatchGroup = DispatchGroup()

        for result in results {
            dispatchGroup.enter()
            
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: T.self) {
                itemProvider.loadObject(ofClass: T.self) { (imageOrNil, errorOrNil) in
                    if let error = errorOrNil {
                        onComplete(nil, error)
                        dispatchGroup.leave()
                    }
                    if let image = imageOrNil as? T {
                        images.append(image)
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            onComplete(images, nil)
        }
    }

    static func loadVideo(fromResults results: [PHPickerResult], onComplete: @escaping (String, Error?) -> Void) {
        guard let itemProvider = results.first?.itemProvider else {
            return
        }

        itemProvider.loadFileRepresentation(forTypeIdentifier: "public.movie") { url, error in
            guard error == nil else{
                onComplete("", error)
                return
            }
            // receiving the video-local-URL / filepath
            guard let url = url else { return }
            // create a new filename
            let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
            // create new URL
            let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
            // copy item to APP Storage
            try? FileManager.default.copyItem(at: url, to: newUrl)

            DispatchQueue.main.async {
                onComplete(newUrl.absoluteString, nil)
            }
        }
    }
}
