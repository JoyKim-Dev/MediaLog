//
//  SimilarContentsCollectionViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/24/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class ContentsCollectionViewCell: UICollectionViewCell {
    
    let moviePosterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configHierarchy()
        configLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContentsCollectionViewCell {
    
    func configHierarchy() {
        contentView.addSubview(moviePosterImageView)
    }
    
    func configLayout() {
        moviePosterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    func configUI(movieData: Media, castData: CastInfo, indexPath: IndexPath, tableViewRow: Int) {
        
        if tableViewRow == 1 {
            if let valid = castData.cast[indexPath.item].profile_path {
                let url = URL(string: "https://image.tmdb.org/t/p/h632\(valid)")
                print(valid)
                moviePosterImageView.kf.setImage(with: url)
            }
        } else {
            if let valid = movieData.results[indexPath.item].poster_path {
                let url = URL(string: "https://image.tmdb.org/t/p/w780\(valid)")
                moviePosterImageView.kf.setImage(with: url)
            } else {
                moviePosterImageView.image = Constant.DummyImage.star
            }
        }
        
        
        //    func configUI(data: SimilarResult, indexPath: IndexPath) {
        //        contentView.layer.cornerRadius = 4
        //        contentView.clipsToBounds = true
        //        contentView.backgroundColor = Constant.Color.GrayLineBg
        //
        //        if indexPath.section == 0 {
        //            if let image = data.poster_path  {
        //                let url = URL(string: "https://image.tmdb.org/t/p/w780\(image)")
        //                moviePosterImageView.kf.setImage(with: url)
        //            } else {
        //                moviePosterImageView.image = Constant.DummyImage.star
        //            }
        //            moviePosterImageView.contentMode = .scaleAspectFill
        //        } else {
        //            return
        //        }
        //
        //    }
        //
        //    func configUI2(data: RecomResult, indexPath: IndexPath) {
        //        contentView.layer.cornerRadius = 4
        //        contentView.clipsToBounds = true
        //        contentView.backgroundColor = Constant.Color.GrayLineBg
        //
        //        if indexPath.section == 0 {
        //            if let image = data.poster_path  {
        //                let url = URL(string: "https://image.tmdb.org/t/p/w780\(image)")
        //                moviePosterImageView.kf.setImage(with: url)
        //            } else {
        //                moviePosterImageView.image = Constant.DummyImage.star
        //            }
        //            moviePosterImageView.contentMode = .scaleAspectFill
        //        } else {
        //            return
        //        }
        //
        //    }
    }
}
