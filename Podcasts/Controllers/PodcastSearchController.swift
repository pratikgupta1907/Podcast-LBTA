//
//  PodcastSearchController.swift
//  Podcasts
//
//  Created by pratik gupta on 30/08/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import UIKit

class PoadCastSearchController: UITableViewController, UISearchBarDelegate {
    
    let podcasts = [
    Podcast(name: "Lets Build That App", artistName: "Brian Voong"),
    Podcast(name: "Lets Build That App", artistName: "Brian Voong")
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
        print(searchText)
        //implement Alamofire
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        return cell
    }
    
}
