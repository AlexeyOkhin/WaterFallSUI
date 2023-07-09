//
//  AsynImage.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 09.07.2023.
//

import SwiftUI

struct AsyncLoadImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {

        Group {
            if imageLoader.isLoading {
                ProgressView() 
            } else {
                Image(uiImage: imageLoader.image ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }

}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLoadImage(withURL: "https://images.unsplash.com/photo-1688355791542-3bc6eb957fe9?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NDExMDJ8MHwxfGFsbHwyfHx8fHx8Mnx8MTY4ODY1OTYxNXw&ixlib=rb-4.0.3&q=85")
    }
}
