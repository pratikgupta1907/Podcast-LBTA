//
//  Episode.swift
//  Podcasts
//
//  Created by pratik gupta on 06/09/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import Foundation
import FeedKit

struct Episode: Decodable {
    var title: String
    var pubDate: Date
    let description: String
    let author: String
    let streamUrl: String
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
    }
}
