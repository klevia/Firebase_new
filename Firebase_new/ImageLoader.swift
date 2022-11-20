//
//  ImageLoader.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 27.04.22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
class ImageLoader: ObservableObject {
    @Published var data: Data?

    func loadImage(url: String) {
        let imageRef = Storage.storage().reference(forURL: url)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
