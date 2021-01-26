//
//  LoadingStateView.swift
//  Test
//
//  Created by Nikhil L on 27/01/21.
//

import SwiftUI

struct LoadingStateView<Content: View>: View {
    @Binding var loadingState: LoadingState
    var contentView: Content
    
    
    init(loadingState: LoadingState, @ViewBuilder contentView: () -> Content) {
        self._loadingState = Binding.constant(loadingState)
        self.contentView = contentView()
    }

    var body: some View {
        ZStack{
            contentView.isHidden(loadingState != LoadingState.Success)
            Text("Failed to fetch Categories").isHidden(loadingState != LoadingState.Failure)
            ProgressView("Loading...").isHidden(loadingState != LoadingState.Loading)
        }
        
    }
}

struct LoadingStateView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingStateView(loadingState: LoadingState.Success, contentView: {
            Text("Success")
        })
    }
}
