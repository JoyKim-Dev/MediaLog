//
//  NetworkRequest.swift
//  MediaLog
//
//  Created by Joy Kim on 6/26/24.
//

import Foundation
import Alamofire

enum Time: String {
    case day
    case week
}

enum Region: String {
    case korea = "KR"
    case usa = "US"
}

//에러 프로토콜 채택하여 에러 상황 예외처리 옵션 구성
enum RequestError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

enum TMDBRequest {
    // path parameter & query parameter 처리: 열거형 연관값 사용
    case movieList(query: String, page: Int)
    case trendingMovie(time: Time)
    case recommendMovie(id:Int)
    case nowPlayingMovie
    case upcomingMovie
    case similarMovie(id: Int)
    case movieCast(id: Int)
    case moviePoster(id: Int)
    
    //enum이라 저장 프로퍼티 사용 불가 >> 연산 프로퍼티 - get 사용
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .movieList:
            return URL(string: baseURL + "search/movie")!
        case .trendingMovie(let time):
            return URL(string: baseURL + "trending/movie/\(time)")!
        case .recommendMovie(let id):
            return URL(string: baseURL + "movie/\(id)/recommendations")!
        case .nowPlayingMovie:
            return URL(string: baseURL + "movie/now_playing")!
        case .upcomingMovie:
            return URL(string: baseURL + "movie/upcoming")!
        case .similarMovie(let id):
            return URL(string: baseURL + "movie/\(id)/similar")!
        case .movieCast(let id):
            return URL(string: baseURL + "movie/\(id)/credits")!
        case .moviePoster(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        }
    }
    
    var header: HTTPHeaders {
        return [
            "Authorization": APIKey.tmdbKey,
            "accept": APIResponseStyle.tmdbJson
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .movieList(let query, let page):
            return ["language": APILanguage.tmdbKorean, "query": query,"page": page]
        case .trendingMovie, .recommendMovie, .similarMovie, .movieCast:
            return ["language": APILanguage.tmdbKorean]
        case .nowPlayingMovie, .upcomingMovie:
            return ["language": APILanguage.tmdbKorean, "region": Region.korea.rawValue]
        case .moviePoster:
            return [:]
        }
    }
}
