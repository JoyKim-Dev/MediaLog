//
//  NetworkManager.swift
//  MediaLog
//
//  Created by Joy Kim on 6/25/24.
//

// func 3가지 : moive data, cast data, poster data
import Foundation
import Alamofire

final class NetworkManager {
    
    // singleton pattern : 무분별한 인스턴스 생성 방지.
    static let shared = NetworkManager()
    private init() {}
    
    typealias AllMovieDataHandler = (Media?, RequestError?) -> Void
    typealias MovieDataHandler = ([Result]?, RequestError?) -> Void
    typealias CastDataHandler = (CastInfo?, RequestError?) -> Void
    typealias PosterDataHandler = ([PosterDetail]?, RequestError?) -> Void
    typealias GenericHandler<T: Decodable> = (T?, RequestError?) -> Void
    
    
    func request<T: Decodable>(api: TMDBRequest, model: T.Type, completionHandler: @escaping GenericHandler<T>) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: T.self) { response in
            print("STATUS: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
                // 여기도 enum 연관값 활용!
            case .success(let value):
                //dump(value.results)
                completionHandler(value, nil)
                
            case .failure(let error):
                print(error)
                // 튜플
                completionHandler(nil, .failedRequest)
            }
        }
    
    }
    
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
                completionHandler(nil, .failedRequest)
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
                completionHandler(nil, .failedRequest)
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
                completionHandler(value, nil)
                
            case .failure(let error):
                print(error)
                // 튜플
                completionHandler(nil, .failedRequest)
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
                completionHandler(nil, .failedRequest)
            }
        }
    }
}
    
