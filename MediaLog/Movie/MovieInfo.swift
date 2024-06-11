//
//  MovieInfo.swift
//  MediaLog
//
//  Created by Joy Kim on 6/12/24.
//

import Foundation

struct Movie: Decodable {
    
    let page: Int
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let vote_average: Double?
}
