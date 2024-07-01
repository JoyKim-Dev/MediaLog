//
//  MovieHomeCollectionViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/29/24.
//

import UIKit
import SnapKit

final class MovieHomeCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
    }
    
     func configUI(data: Result) {
        if let url = data.poster_path {
            let URL = URL(string: "https://image.tmdb.org/t/p/w780\(url)")
            posterImageView.kf.setImage(with: URL)
            posterImageView.layer.cornerRadius = CornerRadius.poster.Radius
            posterImageView.clipsToBounds = true
        } else {
            posterImageView.image = UIImage(systemName: "star")
        }
        
       
    }
}
