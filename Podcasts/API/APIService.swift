//
//  API Service Class.swift
//  Podcasts
//
//  Created by pratik gupta on 31/08/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    //singleton
    
    static let shared = APIService()
    
    
    func fetchPodcasts(searchText: String, completionHandlr: @escaping ([Podcast]) -> ()) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed", err)
                return
            }
            guard let data = dataResponse.data else { return }
            
            //   let dummyString = String(data: data, encoding: .utf8)
            //  print(dummyString ?? "")
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                
//                print("Result search count", searchResults.resultCount)
//
//                searchResults.results.forEach({ (podcast) in
//                    print(podcast.artistName ?? "", podcast.trackName ?? "")
//                })
                
                completionHandlr(searchResults.results)
                
//                self.podcasts = searchResults.results
//                self.tableView.reloadData()
                
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
