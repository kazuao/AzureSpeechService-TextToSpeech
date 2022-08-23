//
//  ViewModel.swift
//  AzureTextToSpeech
//
//  Created by kazunori.aoki on 2022/08/23.
//

import Foundation

final class ViewModel {

    func request(text: String) {
        let keyManager = KeyManager()

        let baseUrl = URL(string: "https://japaneast.tts.speech.microsoft.com")!
        let path = "cognitiveservices/v1"

        let key = keyManager.getApiKey(key: "AZURE_API_KEY") ?? ""

        let xml: String = """
<speak version='1.0' xml:lang='ja-JP'>
    <voice xml:lang='ja-JP' xml:gender='Female' name='ja-JP-NanamiNeural'>\(text)</voice>
</speak>
"""
        let data = xml.data(using: .utf8)!

        let request = RequestBuilder(path: path)
            .method(.post)
            .queryItem(name: "language", value: "ja-JP")
            .header(name: "Ocp-Apim-Subscription-Key", value: key)
            .header(name: "Content-Type", value: "application/ssml+xml")
            .header(name: "X-Microsoft-OutputFormat", value: "audio-16khz-128kbitrate-mono-mp3")
            .body(data)
            .makeRequest(withBaseURL: baseUrl)

        Task {
            async let (res, _) = URLSession.shared.data(for: request)
            do {
                print(try await res)
                SpeechService.shared.speech(audioContent: try await res)

            } catch {
                print("Error: ", error.localizedDescription)
            }
        }
    }
}
