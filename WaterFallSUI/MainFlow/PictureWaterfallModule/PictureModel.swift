//
//  PictureModel.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 06.07.2023.
//

import Foundation

struct Picture: Identifiable, Decodable {
    var id: String
    var alt_description: String
    var urls: [String : String]
}
