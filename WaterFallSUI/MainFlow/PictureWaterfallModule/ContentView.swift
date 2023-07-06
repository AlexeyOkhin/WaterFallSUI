//
//  ContentView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 05.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject var randomImages = PictureViewModel()

    private var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(randomImages.photoArray, id: \.id) { photo in
                    WebImage(url: URL(string: photo.urls["thumb"] ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .cornerRadius(14)
                        .clipped()
                }.padding()
            }.navigationTitle("Pictures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
