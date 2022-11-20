//
//  FBURLImage.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 27.04.22.
//

import SwiftUI

struct FBURLImage: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader()
        imageLoader.loadImage(url: url)
    }

    var body: some View {
        Image(uiImage:
            imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage())
            .resizable()
            .frame(width: 100.0, height: 140.0)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
    }
}
