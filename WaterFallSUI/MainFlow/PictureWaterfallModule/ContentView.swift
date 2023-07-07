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

    @State private var selectedItem: Item? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                HStack(spacing: 16) {
                    VStack {
                        ForEach(Array(randomImages.photoArray.enumerated()), id: \.element.id) { offset, photo in

                            NavigationLink(destination: DetailsView(item: Item(stringUrl: photo.urls["full"] ?? ""))) {
                                WebImage(url: URL(string: photo.urls["thumb"] ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                    }

                    VStack {
                        ForEach(Array(randomImages.photoArray.shuffled().enumerated()), id: \.element.id) { offset, photo in
                            WebImage(url: URL(string: photo.urls["thumb"] ?? ""))
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                .cornerRadius(10)

                        }
                    }
                }.padding()
            }
            .navigationTitle("PhotoLibrary")
        }
    }
}

struct Item {
    let stringUrl: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
