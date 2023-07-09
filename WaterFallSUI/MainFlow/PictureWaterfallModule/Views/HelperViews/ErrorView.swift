//
//  ErrorView.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 08.07.2023.
//

import SwiftUI

struct ErrorView: View {

    @State private var showAlert = true
    
    let error: String
    let action: (()->Void)?

    var body: some View {
        VStack {}
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Внимание ошибка!!!"),
                    message: Text(error),
                    dismissButton: .default(Text("Повторить"), action: {
                        action?()
                    })
                )
            }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Erorr test") {
            print("error test")
        }
    }
}
