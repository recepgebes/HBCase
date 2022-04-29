//
//  ResultModel.swift
//  HBCase
//
//  Created by Recep on 29.04.2022.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artworkUrl100 : URL
    
}
