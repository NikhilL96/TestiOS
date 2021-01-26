//
//  AsyncImage.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import SwiftUI
import Combine

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    
    init(url: String) {
        self._loader = StateObject(wrappedValue: ImageLoader(url: URL(string: url)!))
    }
    
    var body: some View {
        Group {
            if loader.loadingState == LoadingState.Success {
                loader.image?.resizable()
            } else if loader.loadingState == LoadingState.Loading {
                ProgressView()
            } else {
                Image(systemName: "exclamationmark.circle")
            }
        }.onAppear{
            loader.load()
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")
        .aspectRatio(contentMode: .fit)
    }
}

