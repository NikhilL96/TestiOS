//
//  CustomVideoPlayer.swift
//  Test
//
//  Created by Nikhil L on 27/01/21.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: View {
    
    @Binding var avPlayer: AVQueuePlayer
    @Binding var isFullScreen: Bool

    var body: some View {
        ZStack {
            VideoPlayer(player: avPlayer)
                .onDisappear() {
                    avPlayer.removeAllItems()
                }
            VStack{
                HStack{
                    FullScreenButtonView(isFullScreen: $isFullScreen)
                    Spacer()
                }.padding(.all, 5)
                Spacer()
            }.padding(.all, 5)
        }
    }
}

struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CustomVideoPlayer(avPlayer: Binding.constant(AVQueuePlayer()),
                          isFullScreen: Binding.constant(false))
    }
}
