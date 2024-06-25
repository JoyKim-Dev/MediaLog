//
//  NetworkManager.swift
//  MediaLog
//
//  Created by Joy Kim on 6/25/24.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    func movieCast(id: Int, completionHandler: @escaping(Cast) -> Void) {
        
        let url = APIURL.movieCastURL(id:id)
        print(url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": APIResponseStyle.tmdbJson
        ]
        let param:Parameters = ["language": APILanguage.tmdbKorean]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Cast.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    
                    completionHandler(value)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func similarMovie(id: Int, completionHandler: @escaping ([SimilarResult]) -> Void) {
        
        let url = APIURL.similarMovieURL(id: id)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": APIResponseStyle.tmdbJson
        ]
        let param:Parameters = [
            "language": APILanguage.tmdbKorean
        ]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Similar.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    dump(value.results)
                    completionHandler(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func recommendMovie(id: Int, completionHandler: @escaping ([SimilarResult]) -> Void) {
        
        let url = APIURL.recomMovieURL(id: id)
        print(url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": APIResponseStyle.tmdbJson
        ]
        let param:Parameters = ["language": APILanguage.tmdbKorean]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Similar.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    dump(value.results)
                    completionHandler(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
