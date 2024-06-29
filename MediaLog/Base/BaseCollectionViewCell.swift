//
//  BaseCollectionViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/29/24.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    
    


