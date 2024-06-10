//
//  ReuseIdentifierProtocol.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    
    static var identifier: String {get}
}

extension UIViewController: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
