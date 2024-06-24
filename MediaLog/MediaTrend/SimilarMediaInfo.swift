//
//  SimilarMediaInfo.swift
//  MediaLog
//
//  Created by Joy Kim on 6/24/24.
//
struct Similar: Decodable {
    let page: Int
    let results: [SimilarResult]
}

struct SimilarResult: Decodable {
    let original_title: String?
    let original_name: String?
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let adult: Bool
    let title: String?
    let name: String?
    let original_language: String
    let popularity: Double?
    let release_date: String?
    let first_air_date: String?
    let vote_average: Double
    let vote_count: Int
    let id: Int
    
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
