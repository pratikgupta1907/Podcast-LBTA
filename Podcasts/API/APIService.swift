//
//  API Service Class.swift
//  Podcasts
//
//  Created by pratik gupta on 31/08/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            
            
            if let error = result.error {
                print("failed to parse", error)
                return
            }
            
            guard let feed = result.rssFeed else { return }
            
            completionHandler(feed.toEpisode())

        }
        
    }
    
    func fetchPodcasts(searchText: String, completionHandlr: @escaping ([Podcast]) -> ()) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed", err)
                return
            }
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandlr(searchResults.results)
                
            } catch let decodeErr {
                print("failed to decode:", decodeErr)
            }
        }
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
}
