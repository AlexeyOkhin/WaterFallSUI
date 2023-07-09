//
//  LoadPhotoViewModel.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 08.07.2023.
//

import Foundation
import Combine
import UIKit

class PhotoViewModel : ObservableObject {

    enum State {
        case loading
        case loaded([PhotoModel])
        case failed(Error)
    }

    @Published private(set) var state = State.loading

    private var currentPage = 3
    private var cancellable = Set<AnyCancellable>()
    private var allPhotos: [PhotoModel] = []
    private let accessKey = Bundle.main.infoDictionary?["ImageAccessKey"] as? String
    private let host = Bundle.main.infoDictionary?["ImageHost"] as? String

    init() {
        loadPhotos()
    }

    func reloadPhoto() {
        state = .loading
        loadPhotos()
    }

    func loadPhotos() {
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

        let urlString = modernHost + "photos?page=\(currentPage)&per_page=10"

        guard
            let url = URL(string: urlString)
        else {
            state = .failed(URLError(URLError.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.addValue("Client-ID " + accessKey, forHTTPHeaderField: "Authorization")
        request.addValue("v1", forHTTPHeaderField: "Accept-Version")

        let photosService = APIService<[PhotoModel]>(request)

        photosService.getData()
            .delay(for: 0.8, scheduler: RunLoop.main) // задержка для того чтоб увидеть постраничную загрузку
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    guard let self = self else {return}
                    self.state = .failed(error)
                case .finished: break
                }
            }
            receiveValue: { [weak self] receivedPhotos in
                guard let self = self else {return}
                self.allPhotos.append(contentsOf: receivedPhotos)
                self.state = .loaded(self.allPhotos)
                self.currentPage += 1
            }
            .store(in: &cancellable)
    }
}
