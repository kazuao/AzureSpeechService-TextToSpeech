//
//  ContentView.swift
//  AzureTextToSpeech
//
//  Created by kazunori.aoki on 2022/08/23.
//

import SwiftUI

struct ContentView: View {

    private var model = ViewModel()

    var body: some View {

        Button(action: { model.request(text: "東京特許許可局") }) {
            Text("Request")
                .font(.largeTitle.bold())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
