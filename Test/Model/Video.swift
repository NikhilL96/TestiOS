//
//  Video.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import Foundation


struct Video: Hashable, Identifiable, Codable {
    let id = UUID()
    var title: String?
    var description: String?
    var thumbnailURL: String?
    var videoURL: String?
    var categories: String?
    
    func getVideoURL() -> URL? {
        guard let safeURL = self.videoURL else {
            return nil
        }
        return URL(string: safeURL)
    }

}
        
struct VideoResponseModel: Hashable, Codable {
    var code: Int?
    var response: VideoResponseBody?
    
}
        
struct VideoResponseBody: Hashable, Codable {
    var videos: [String : Video]?
}
  
