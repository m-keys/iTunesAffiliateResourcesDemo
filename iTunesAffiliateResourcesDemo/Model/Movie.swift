//
//  Movie.swift
//  iTunesAffiliateResources
//
//  Created by Александр Макаров on 06.11.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var artistName: String?
    var trackName: String?
    var previewUrl: String?
    var artworkUrl100: String
}
