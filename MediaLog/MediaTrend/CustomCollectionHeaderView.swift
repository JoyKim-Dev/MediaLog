//
//  RecomContentsInfo.swift
//  MediaLog
//
//  Created by Joy Kim on 6/24/24.
//
import UIKit

class CustomCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "CustomCollectionHeaderView"
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Header".uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    
    func configure() {
        backgroundColor = .systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}

