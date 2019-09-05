//
//  EpisodesController.swift
//  Podcasts
//
//  Created by pratik gupta on 01/09/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = "\(podcast.trackName ?? "Trackname")"
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes() {
        print("looking for episodes at feed url", podcast.feedUrl ?? "")
        
        guard let feedUrl = podcast.feedUrl else { return }
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            //print("succes",result.isSuccess)
            
            //enum values
            switch result {

            case let .rss(feed):
                
                var episodes = [Episode]()
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(title: feedItem.title ?? "")
                    episodes.append(episode)
                })
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
                
            case let .failure(error):
                print("failed to parse feed:", error)
                
            default :
                print(" found a feed")
                break
            }
        }
    }
    
   fileprivate let cellId = "cellId"
    
    struct Episode {
        var title: String
    }
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    //MARK:- SetUp Work

    fileprivate func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = episodes[indexPath.row].title
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
