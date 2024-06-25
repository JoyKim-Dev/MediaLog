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
    let poster_path: String
}
