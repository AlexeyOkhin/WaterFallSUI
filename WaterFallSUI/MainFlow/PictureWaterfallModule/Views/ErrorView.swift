//
//  ErrorView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 08.07.2023.
//

import SwiftUI

struct ErrorView: View {
    let error: String

    var body: some View {
        VStack {
            Spacer()
            Text(error)
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error")
    }
}
