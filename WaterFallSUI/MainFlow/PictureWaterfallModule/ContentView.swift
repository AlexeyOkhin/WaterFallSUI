//
//  ContentView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 05.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            HStack(spacing: 16) {
                VStack {
                    ForEach(0...3, id: \.self) { index in
                        CardView()
                            .frame(height: index % 2 == 0 ? 320 : 200)
                    }
                }
                VStack {
                    ForEach(0...3, id: \.self) { index in
                        CardView()
                            .frame(height: index % 2 != 0 ? 320 : 200)
                    }
                }
            }.padding()
        }
    }
}

struct Card {
    let title: String
    let imageName: String
}

struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
