//
//  MovieCollectionViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/12/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    let moviePosterImageView = UIImageView()
    let movieTitleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieCollectionViewCell {
    
    func configHierarchy() {
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(movieTitleLabel)
    }
    
    func configLayout() {
        moviePosterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(moviePosterImageView).inset(5)
        }
    }
    
    func configUI() {
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        contentView.backgroundColor = .lightGray
        
        moviePosterImageView.image = UIImage(systemName: "star")
        moviePosterImageView.contentMode = .scaleAspectFill
        
        movieTitleLabel.text = "영화제목"
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
    }
}
