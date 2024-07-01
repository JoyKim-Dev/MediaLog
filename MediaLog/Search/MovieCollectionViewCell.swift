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

final class MovieCollectionViewCell: UICollectionViewCell {
    
    
    let moviePosterImageView = UIImageView()
    let movieTitleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configHierarchy()
        configLayout()
        
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
            make.horizontalEdges.equalTo(moviePosterImageView)
            make.bottom.lessThanOrEqualTo(moviePosterImageView)
            
        }
    }
    
     func configUI(data: Result) {
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        contentView.backgroundColor = Constant.Color.GrayLineBg
        
        if let image = data.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(image)")
            moviePosterImageView.kf.setImage(with: url)
        } else {
            moviePosterImageView.image = Constant.DummyImage.star
        }
        moviePosterImageView.contentMode = .scaleAspectFill
        
        if let title = data.title {
            movieTitleLabel.text = " \(title)"
        } else {
            movieTitleLabel.text = "정보없음"
        }
        movieTitleLabel.textColor = Constant.TextColor.darkBGWhite
        movieTitleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.lineBreakMode = .byCharWrapping
        movieTitleLabel.backgroundColor = .black.withAlphaComponent(0.5)

    }
}
