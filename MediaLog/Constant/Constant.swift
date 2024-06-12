//
//  Constant.swift
//  MediaLog
//
//  Created by Joy Kim on 6/12/24.
//

import UIKit

enum Constant {
    
    enum Color {
        
        static let whiteViewBg = UIColor.white
        static let whiteLabelBg = UIColor.white
        static let GrayLineBg = UIColor.lightGray
        
        static let blackDefaultBtn = UIColor.black
        static let redAccentBtn = UIColor.red
    }
    
    enum TextColor {
        static let darkBGWhite = UIColor.white
        static let defaultBlack = UIColor.black
        static let accentRed = UIColor.red
        static let softGray = UIColor.gray
    }
    
    enum Font {
        static let defaultRegular13 = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let bold14 = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    enum Radius: Int {
        case imageView = 8
        case textField = 6
        case cell = 12
    }
    
    enum DummyImage {
        static let star = UIImage(systemName: "star")
    }
}
