//
//  PictureViewModel.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 06.07.2023.
//

import Foundation

class PictureViewModel: ObservableObject {
    @Published var photoArray: [Picture] = []

    private let accessKey = Bundle.main.infoDictionary?["ImageAccessKey"] as? String
    private let host = Bundle.main.infoDictionary?["ImageHost"] as? String
    private let session = URLSession(configuration: .default)

    init() {
        loadData(page: 1)
    }

    func loadData(page: Int, per_page: Int = 30) {
        guard
            let accessKey = accessKey,
            let host = host
        else {
            return
        }

        var modernHost = host
        modernHost.removeAll { char in
            char == "\\"
        }

        let urlString = modernHost + "photos?page=\(page)&per_page=\(per_page)"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Client-ID " + accessKey, forHTTPHeaderField: "Authorization")
        request.addValue("v1", forHTTPHeaderField: "Accept-Version")

        session.dataTask(with: request) { (data, _, error) in
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
