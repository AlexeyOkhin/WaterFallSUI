//
//  PhotoModel.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 06.07.2023.
//

import Foundation

struct PhotoModel: Identifiable, Codable, Hashable {
    var id: String
    var urls: Urls
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small, thumb: String
}
