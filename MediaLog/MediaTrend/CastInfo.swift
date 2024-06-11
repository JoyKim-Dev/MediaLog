//
//  CastInfo.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import Foundation

struct CastInfo: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String?
    let original_name: String?
    let profile_path: String?
    let character: String?

}
