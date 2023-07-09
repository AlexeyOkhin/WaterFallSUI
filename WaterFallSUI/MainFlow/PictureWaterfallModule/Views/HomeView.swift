//
//  HomeView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 08.07.2023.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var photoViewModel: PhotoViewModel = PhotoViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                switch photoViewModel.state {
                case .loading:
                    LoadingView()
                case .loaded(let photos):
                    ScrollView {
                        PhotoLibraryView(photos) { photo in

                            guard let lastPhoto = photos.last else { return }
                            if lastPhoto.id == photo.id {
                                photoViewModel.loadPhotos()
                            }
                        }
                        .padding([.horizontal], 16)
                        ProgressView("Loading new page...")
                    }

                case .failed(let error):
                    ErrorView(error: "\(error.localizedDescription)"){
                        photoViewModel.reloadPhoto()
                    }
                }

            }.navigationTitle("Photo Library")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
