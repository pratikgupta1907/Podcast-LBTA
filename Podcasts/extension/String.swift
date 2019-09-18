//
//  String.swift
//  Podcasts
//
//  Created by pratik gupta on 13/09/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import Foundation

extension String {
    
    func toSecureHTTPS() -> String{
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
