//
//  PodcastSearchController.swift
//  Podcasts
//
//  Created by pratik gupta on 30/08/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import UIKit
import Alamofire

class PoadCastSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [
        Podcast(trackName: "Lets Build That App", artistName: "Brian Voong"),
        Podcast(trackName: "Lets Build That App", artistName: "Brian Voong")
    ]
    
    let cellId = "cellId"
    // lets implement a UISearchController
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        setUpTableView()
        
    }
    
    //MARK:- SetUP Work
    
    fileprivate func setUpTableView() {
        //1. Register a cell for our tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setUpSearchBar() {
        tableView.tableFooterView = UIView()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       // print(searchText)
        //implement Alamofire
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }
            guard let data = dataResponse.data else { return }
            
            //   let dummyString = String(data: data, encoding: .utf8)
            //  print(dummyString ?? "")
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                
                print("Result search count", searchResults.resultCount)
                
                searchResults.results.forEach({ (podcast) in
                    print(podcast.artistName ?? "", podcast.trackName ?? "")
                })
                
                self.podcasts = searchResults.results
                self.tableView.reloadData()
                
            } catch let decodeErr {
                print("failed to decode:", decodeErr)
            }
        }
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        return cell
    }
    
}
