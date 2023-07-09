//
//  LoadingView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 08.07.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Loading...")
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
