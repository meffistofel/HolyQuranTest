//
//  SaveLoadingImage.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 22.10.2022.
//

import UIKit

extension URL {
    func loadImage(_ image: inout UIImage) {
        if let loaded = UIImage(contentsOfFile: self.path) {
            image = loaded
        }
    }
    func saveImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: self)
        }
    }
}

/*
 @State private var image = UIImage(systemName: "xmark")!
 
 private var url: URL {  let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  return paths[0].appendingPathComponent("image.jpg")}
 var body: some View {
 Image(uiImage: image)
   .onAppear {   url.load(&image)  }
   .onTapGesture {   url.save(image)  }
 }
 */
