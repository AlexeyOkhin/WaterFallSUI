//
//  PictureViewModel.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 06.07.2023.
//

import Foundation

class PictureViewModel: ObservableObject {
    @Published var photoArray: [Picture] = []

    init() {
        loadData()
    }

    func loadData() {
        let key = Bundle.main.infoDictionary?["ImageAccessKey"] as? String
        let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key ?? "")"
        let session = URLSession(configuration: .default)

        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode([Picture].self, from: data)
                for photo in json {
                    DispatchQueue.main.async {
                        self.photoArray.append(photo)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
