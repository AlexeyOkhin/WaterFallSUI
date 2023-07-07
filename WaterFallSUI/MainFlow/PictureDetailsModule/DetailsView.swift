//
//  DetailsView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 06.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    let item: Item
    var body: some View {
        WebImage(url: URL(string: item.stringUrl))
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fit)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(item: Item(stringUrl: "https://images.unsplash.com/photo-1688355791542-3bc6eb957fe9?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NDExMDJ8MHwxfGFsbHwyfHx8fHx8Mnx8MTY4ODY1OTYxNXw&ixlib=rb-4.0.3&q=85")) 
    }
}
