//
//  GridImageCell.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct GridImageCell: View {
    
//    let url: String
    let width: CGFloat
    let height: CGFloat
    let imageData: Data?
    
//    init(url: String, width: CGFloat = 100, height: CGFloat = 100) {
//        self.url = url
//        self.width = width
//        self.height = height
//        self.imageData = nil
//    }
    
    init(imageData: Data?, width: CGFloat = 100, height: CGFloat = 100) {
        self.width = width
        self.height = height
        self.imageData = imageData
    }
    
    var body: some View {
//        AsyncImage(url: URL(string: url)) { phase in
//            switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                    image.resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: width, height: height)
//                        .cornerRadius(20)
//                        .shadow(radius: 20)
//                default:
//                    Image(systemName: "photo")
//            }
//        }

        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .cornerRadius(20)
                .shadow(radius: 20)
        } else {
            ProgressView()
            Image(systemName: "photo")
        }
    }
}
