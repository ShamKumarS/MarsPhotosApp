//
//  PicsImageView.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct GridImageCell: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                case .failure:
                    Image(systemName: "photo")
                default:
                    EmptyView()
            }
        }
    }
}
