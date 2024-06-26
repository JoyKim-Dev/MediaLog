//
//  MediaTrendInfo.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//

import Foundation

// MARK: - Movie Data
struct Media: Decodable {
    let page: Int
    var results: [Result]
}

struct Result: Decodable {
    let original_title: String?
    let original_name: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let adult: Bool?
    let title: String?
    let name: String?
    let original_language: String?
    let popularity: Double?
    let release_date: String?
    let first_air_date: String?
    let vote_average: Double?
    let vote_count: Int?
    let id: Int?
    
    var displayTitle: String? {
        return title ?? name
    }
    
    var displayOriginalTitle: String? {
        return original_title ?? original_name
    }
    
    var displayDate: String? {
        return release_date ?? first_air_date
    }
}

// MARK: - Poster Data

struct Poster: Decodable {
    let backdrops: [PosterDetail]
}

struct PosterDetail: Decodable {
    let aspect_ratio: Double
    let height: Int
    let width: Int
    let file_path: String
}

// MARK: - Cast Data

struct CastInfo: Decodable {
    let id: Int
    let cast: [CastDetail]
}

struct CastDetail: Decodable {
    let name: String?
    let original_name: String?
    let profile_path: String?
    let character: String?
}

