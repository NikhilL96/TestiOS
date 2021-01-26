//
//  Services.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import Foundation


class Services{
    func getCategories(noCompletion: @escaping ([Category]?) -> ()) {
        let url: URL? = URL(string: "http://www.mocky.io/v2/5e2bebd23100007a00267e51")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let safeData = data else {
                noCompletion(nil)
                return
            }
            
            let dataRespose = try? JSONDecoder().decode(CategoryResponseModel.self, from: safeData)
            
            DispatchQueue.main.async {
                guard let categories = dataRespose?.response?.videoCategories?.values else {
                    noCompletion(nil)
                    return
                }
                noCompletion(Array(categories))
            }
            
        }.resume()
        
    }
    
    func getVideos(category: String, noCompletion: @escaping ([Video]?) -> ()) {
        let url: URL? = URL(string: "http://www.mocky.io/v2/5e2beb5a3100006600267e4e")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let safeData = data else {
                noCompletion(nil)
                return
            }
            let dataRespose: VideoResponseModel? = try? JSONDecoder().decode(VideoResponseModel.self, from: safeData)

            DispatchQueue.main.async {
                guard let allVideos = dataRespose?.response?.videos?.values else {
                    noCompletion(nil)
                    return
                }
                var categoryVideos: [Video] = []

                allVideos.forEach{ video in
                    video.categories?.components(separatedBy: ",").forEach({videoCategory in
                        if category == videoCategory {
                            categoryVideos.append(video)
                        }
                    })
                }

                noCompletion(Array(categoryVideos))
            }
            
        }.resume()
        
    }
}
