//
//  VideoPlayerView.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var category: Category?
    let service = Services()
    @State var avPlayer = AVQueuePlayer()
    
    @State var isFullScreen = false
    @State var videos: [Video] = []
    @State var selectedVideo:Video? = nil
    @State var loadingState: LoadingState = LoadingState.Loading
    
    var body: some View {
        LoadingStateView<Group>(loadingState: loadingState, contentView: {
            Group{
                GeometryReader { geometry in
                    VStack() {
                        CustomVideoPlayer(avPlayer: $avPlayer, isFullScreen: $isFullScreen)
                            .frame(width: geometry.size.width, height: isFullScreen ? geometry.size.height: geometry.size.height / (4/3))
                            .animation(.linear)
                        
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(videos, content: { video in
                                    AsyncImage(
                                        url: video.thumbnailURL!).aspectRatio(contentMode: .fill)
                                    .onTapGesture {
                                        selectedVideo = video
                                        if let safeVideoURL = selectedVideo?.getVideoURL() {
                                            avPlayer.replaceCurrentItem(with: AVPlayerItem(url: safeVideoURL))
                                        }
                                    }
                                    .border(Color.blue, width:getBorderWidth(video: video))
                                })
                                
                            }
                        }.frame(width: geometry.size.width, height: geometry.size.height/4)
                        .animation(.linear)
                        
                    }.onAppear() {
                        fetchVideos()
                    }.onDisappear() {
                        avPlayer.removeAllItems()
                    }
                }.background(Color.black)
                .edgesIgnoringSafeArea(.leading)
                .edgesIgnoringSafeArea(.trailing)
                .edgesIgnoringSafeArea(.bottom)
                
            }
        })
    }
    
    private func getBorderWidth(video: Video) -> CGFloat {
        if selectedVideo?.videoURL == video.videoURL {
            return 4
        }
        else {
            return 0
            
        }
    }
    
    private func fetchVideos() {
        service.getVideos(category: category?.name ?? "") { (videos) in
            guard let nonNullVideos = videos else {
                loadingState = LoadingState.Failure
                return
            }
            loadingState = LoadingState.Success
            sortVideos(videos: nonNullVideos)
            selectedVideo = self.videos[0]
            if let safeVideoURL = selectedVideo?.getVideoURL() {
                avPlayer.replaceCurrentItem(with: AVPlayerItem(url: safeVideoURL))
            }
        }
    }
    
    
    private func sortVideos(videos: [Video]) {
        self.videos =
            videos.sorted(by: {
                guard let guardedTitle1 = $0.title else {
                    return false
                }
                guard let guardedTitle2 = $1.title else{
                    return false
                }
                if guardedTitle1.count != guardedTitle2.count {
                    return guardedTitle1.count < guardedTitle2.count
                } else {
                    return guardedTitle1<guardedTitle2
                }
                
            })
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoPlayerView(category: Category(name: "Category1", image: "Category1"))
        }
    }
}
