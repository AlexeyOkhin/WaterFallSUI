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

        photos.forEach { photo in
            let index = photos.firstIndex {$0.id == photo.id }

            if let index = index {
                if index % 2 == 0  {
                    list1.append(photo)
                } else {
                    list2.append(photo)
                }
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
                    NavigationLink(destination: DetailsView(item: photo)) {
                        WebImage(url: URL(string: photo.urls.thumb))
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onAppear(perform: { onAppearClosure(photo) })
                    }
                }
            }

            LazyVStack(spacing: 8) {
                ForEach(splitArray[1]) { photo in
                    NavigationLink(destination: DetailsView(item: photo)) {
                        WebImage(url: URL(string: photo.urls.thumb))
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onAppear(perform: { onAppearClosure(photo) })
                    }
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
}
