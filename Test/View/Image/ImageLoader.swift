//
//  ImageLoader.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: Image?
    private let url: URL
    var loadingState: LoadingState = LoadingState.Loading

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }
    private var cancellable: AnyCancellable?

    func load() {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data)}
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    if let data = $0 {
                        self?.image = Image(uiImage: data)
                        self?.loadingState = LoadingState.Success
                    } else {
                        self?.image = nil
                        self?.loadingState = LoadingState.Failure
                    }
                }
        }
        
    func cancel() {
            cancellable?.cancel()
        }
}
