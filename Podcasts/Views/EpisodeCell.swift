//
//  EpisodeCell.swift
//  Podcasts
//
//  Created by pratik gupta on 06/09/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class EpisodeCell: UITableViewCell {

    @IBOutlet var episodeImageView: UIImageView! {
        didSet {
            episodeImageView.isSkeletonable = true
        }
    }
    @IBOutlet var pubDateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
            titleLabel.isSkeletonable = true
        }
    }
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
            descriptionLabel.isSkeletonable = true
        }
    }
    
 var episode: Episode! {
     didSet {
        titleLabel.text = episode.title
        descriptionLabel.text = episode.description
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
        
        let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "")
        episodeImageView.sd_setImage(with: url, completed: nil)
      }
   }
}
