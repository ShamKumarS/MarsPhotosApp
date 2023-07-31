//
//  GridImageCell.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct GridImageCell: View {
    
    let width: CGFloat
    let height: CGFloat
    let imageData: Data?
    
    init(imageData: Data?, width: CGFloat = 100, height: CGFloat = 100) {
        self.width = width
        self.height = height
        self.imageData = imageData
    }
    
    var body: some View {
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
        }
    }
}
