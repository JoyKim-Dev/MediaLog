//
//  NetworkManager.swift
//  MediaLog
//
//  Created by Joy Kim on 6/25/24.
//

// func 3가지 : moive data, cast data, poster data
import Foundation
import Alamofire

class NetworkManager {
    
    // singleton pattern : 무분별한 인스턴스 생성 방지.
    static let shared = NetworkManager()
    private init() {}
    
    typealias AllMovieDataHandler = (Media?, String?) -> Void
    typealias MovieDataHandler = ([Result]?, String?) -> Void
    typealias CastDataHandler = ([CastDetail]?, String?) -> Void
    typealias PosterDataHandler = ([PosterDetail]?, String?) -> Void
    
    func allMovieData(api: TMDBRequest, completionHandler: @escaping AllMovieDataHandler) {
        print(#function)
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: Media.self) { response in
            print("STATUS: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
                // 여기도 enum 연관값 활용!
            case .success(let value):
                //dump(value.results)
                completionHandler(value, nil)
                
            case .failure(let error):
                print(error)
                // 튜플
                completionHandler(nil, "잠시 후 다시 시도해주세요.")
            }
        }
    }
    
    func movieData(api: TMDBRequest, completionHandler: @escaping MovieDataHandler) {
        print(#function)
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: Media.self) { response in
            print("STATUS: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
                // 여기도 enum 연관값 활용!
            case .success(let value):
                //dump(value.results)
                completionHandler(value.results, nil)
                
            case .failure(let error):
                print(error)
                // 튜플
                completionHandler(nil, "잠시 후 다시 시도해주세요.")
            }
        }
    }
    
    func castData(api: TMDBRequest, completionHandler: @escaping CastDataHandler) {
        print(#function)
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: CastInfo.self) { response in
            print("STATUS: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
                // 여기도 enum 연관값 활용!
            case .success(let value):
                //dump(value.results)
                completionHandler(value.cast, nil)
                
            case .failure(let error):
                print(error)
                // 튜플
                completionHandler(nil, "잠시 후 다시 시도해주세요.")
            }
        }
    }
    
    func posterData(api: TMDBRequest, completionHandler: @escaping PosterDataHandler) {
        print(#function)
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: Poster.self) { response in
            print("STATUS: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
                // 여기도 enum 연관값 활용!
            case .success(let value):
                //dump(value.results)
                completionHandler(value.backdrops, nil)
                
            case .failure(let error):
                print(error)
                // 튜플
                completionHandler(nil, "잠시 후 다시 시도해주세요.")
            }
        }
    }
}
    
