//
//  ImageLoaderService.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 05.07.2023.
//

import UIKit

protocol ImageLoaderProtocol {

    func loadImage(from stringUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    func fetchImagesUrl(page: Int, per_page: Int, completion: @escaping ([String], Error?) -> Void)
}

struct ImageLoader {

    private var accessKey = Bundle.main.infoDictionary?["ImageAccessKey"] as? String

    private var host = Bundle.main.infoDictionary?["ImageHost"] as? String

    let session = URLSession(configuration: .default)
}

extension ImageLoader: ImageLoaderProtocol {

    func loadImage(from stringUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let url = URL(string: stringUrl) {
            session.dataTask(with: url) { data, _, error in

                if let error = error {
                    completion(.failure(error))
                }
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }.resume()
        }
    }

    func fetchImagesUrl(page: Int, per_page: Int = 30, completion: @escaping ([String], Error?) -> Void) {
        guard
            let accessKey = accessKey,
            let host = host
        else {
            return
        }

        var newHost = host
        newHost.removeAll { char in
            char == "\\"
        }

        let urlString = newHost + "photos?page=\(page)&per_page=\(per_page)"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Client-ID " + accessKey, forHTTPHeaderField: "Authorization")
        request.addValue("v1", forHTTPHeaderField: "Accept-Version")
        session.dataTask(with: request) { data, _, error in
            if let error {
                completion([], error)
                return
            }

            if let data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let items = json as? [[String: Any]] {
                        let items = items.compactMap { $0["urls"] as? [String: Any] }.compactMap { $0["thumb"] as? String }
                        completion(items, nil)
                    }
                } catch let error as NSError {
                    completion([], error)
                    return
                }
            }
        }.resume()
    }
}
