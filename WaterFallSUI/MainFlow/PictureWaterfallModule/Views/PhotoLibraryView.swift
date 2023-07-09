//
//  PhotoLibraryView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 08.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoLibraryView: View {

    let photos: [PhotoModel]
    let onTileCallback: ((PhotoModel) -> Void)?

    init(_ pictures: [PhotoModel], onTileAppear: ((PhotoModel) -> Void)? = nil) {
        self.photos = pictures
        self.onTileCallback = onTileAppear
    }

    private var splitArray: [[PhotoModel]] {
        var result: [[PhotoModel]] = []

        var list1: [PhotoModel] = []
        var list2: [PhotoModel] = []

        photos.enumerated().forEach { index, photo in
            if index % 2 == 0  {
                list1.append(photo)
            } else {
                list2.append(photo)
            }
        }
        result.append(list1)
        result.append(list2)
        return result

    }

    var body: some View {

        HStack(alignment: .top) {

            LazyVStack(spacing: 8) {
                ForEach(splitArray[0]) { photo in
                    showPicture(photo)
                }
            }

            LazyVStack(spacing: 8) {
                ForEach(splitArray[1]) { photo in
                    showPicture(photo)
                }
            }
        }
    }

    func onAppearClosure(_ photo: PhotoModel) {
        guard let onTileCallback = onTileCallback else {
            return
        }
        onTileCallback(photo)
    }

    private func showPicture(_ photo: PhotoModel) -> some View {
        return NavigationLink(destination: DetailsView(item: photo)) {
            WebImage(url: URL(string: photo.urls.thumb))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .renderingMode(.original)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onAppear(perform: { onAppearClosure(photo) })
        }.buttonStyle(BouncyStyle())
    }
}

private struct BouncyStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}
