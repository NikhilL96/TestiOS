//
//  ContentView.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import SwiftUI

enum LoadingState {
    case Loading
    case Success
    case Failure
}

struct ContentView: View {
    
    @State var categories: [Category] = []
    private let services = Services()
    @State var loadingState: LoadingState = LoadingState.Loading

    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            LoadingStateView<ScrollView>(loadingState: loadingState, contentView: {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: layout, spacing: 20) {
                        ForEach(categories, content: { category in
                            NavigationLink(
                                destination: VideoPlayerView(category: category)) {
                                AsyncImage(
                                         url: category.image!).aspectRatio(contentMode: .fit)
                                .padding()
                            }
                        })
                        .padding(.all, 10.0)
                    }
                }
            })
        }.onAppear() {
            fetchCategories()
        }
    }
    
    private func fetchCategories() {
        services.getCategories { (categories) in
                guard let nonNullCategories = categories else {
                    loadingState = LoadingState.Failure
                    return
                }
            loadingState = LoadingState.Success
            self.categories =
                nonNullCategories.sorted(by: {
                    guard let guardedName1 = $0.name else {
                        return false
                    }
                    guard let guardedName2 = $1.name else{
                        return false
                    }
                    if guardedName1.count != guardedName2.count {
                        return guardedName1.count < guardedName2.count
                    } else {                                   return guardedName1<guardedName2
                    }
                                                        
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


