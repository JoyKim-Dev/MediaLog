//
//  Resource.swift
//  MediaLog
//
//  Created by Joy Kim on 6/29/24.
//

import UIKit

enum Icon {
    static let search = UIImage(systemName: "magnifyingglass")
    static let chevronRight = UIImage(systemName: "chevron.right")
    static let chevronLeft = UIImage(systemName: "chevron.left")
    static let xMark = UIImage(systemName: "xmark")
    static let like = UIImage(systemName: "heart.fill")
    static let unlike = UIImage(systemName: "heart")
}

enum Color {
    static let mainPurple = UIColor(red: 0.608, green: 0.525, blue: 0.741, alpha: 1)
    static let basePink = UIColor(red: 0.886, green: 0.733, blue: 0.914, alpha: 1)
    static let blackForBasicText = UIColor.black
}

enum Font {
    static let semiBold14forBasicInfo = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let semiBold16forSubLable = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    static let heavy20forTitle = UIFont.systemFont(ofSize: 20, weight: .heavy)
    
    static let appTitleFont = UIFont.systemFont(ofSize: 50, weight: .black)
}

enum CornerRadius {
    
    case poster
    
    var Radius: CGFloat {
        switch self {
        case .poster:
            return 5
        }
    }
}

