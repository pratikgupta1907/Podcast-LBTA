//
//  RssFeed.swift
//  Podcasts
//
//  Created by pratik gupta on 14/09/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import FeedKit

extension RSSFeed {
    
    func toEpisode() -> [Episode] {
        
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        var episodes = [Episode]()
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }
            episodes.append(episode)
        })
        return episodes
    }
}
