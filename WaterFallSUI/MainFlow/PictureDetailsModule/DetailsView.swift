//
//  DetailsView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 06.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {

    let item: PhotoModel

    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = CGSize.zero

    // MARK: - Private Methods

    private func resetImageState() {

        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }

    // MARK: - Content

    var body: some View {
        WebImage(url: URL(string: item.urls.full))
            .placeholder(content: {ProgressView()})
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 12, x:2, y: 2)
            .animation(.linear(duration: 1), value: isAnimating)
            .offset(x: imageOffset.width, y: imageOffset.height)
            .scaleEffect(imageScale)

        //MARK: - 1. Tap Gesture

            .onTapGesture(count: 2) {
                if imageScale == 1 {
                    withAnimation(.spring()){
                        imageScale = 5

                    }
                } else {
                    resetImageState()

                }
            }

        //MARK: - 2. Drag gesture

            .gesture(DragGesture()
                .onChanged{ value in
                    withAnimation(.linear(duration: 1)){
                        if imageScale <= 1  {
                            imageOffset = value.translation
                        } else {
                            imageOffset = value.translation
                        }
                    }
                }
                .onEnded{ value in
                    if imageScale <= 1 {
                        resetImageState()
                    }
                }
            )

        // MARK: - 3. Magnification gesture
        
            .gesture(
                MagnificationGesture()
                    .onChanged{ value in
                        withAnimation(.linear(duration: 1)){
                            if imageScale >= 1 && imageScale <= 5 {
                                imageScale = value
                            } else if imageScale > 5 {
                                imageScale = 5
                            }
                        }
                    }
                    .onEnded{ _ in

                        if imageScale > 5 {
                            imageScale = 5
                        } else if imageScale <= 1 {
                            resetImageState()
                        }
                    }
            )
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(item: PhotoModel(id: "234", urls: Urls(raw: "", full: "https://images.unsplash.com/photo-1688355791542-3bc6eb957fe9?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NDExMDJ8MHwxfGFsbHwyfHx8fHx8Mnx8MTY4ODY1OTYxNXw&ixlib=rb-4.0.3&q=85", regular: "", small: "", thumb: "")))
    }
}
