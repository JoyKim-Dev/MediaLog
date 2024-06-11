//
//  MediaDetailCastTableViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class MediaDetailCastTableViewCell: UITableViewCell {

    let castImage = UIImageView()
    let castRealNameLabel = UILabel()
    let characterNameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        configHierarchy()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MediaDetailCastTableViewCell {
    
    func configHierarchy() {
        contentView.addSubview(castImage)
        contentView.addSubview(castRealNameLabel)
        contentView.addSubview(characterNameLabel)
    }
    
    func configLayout() {
        castImage.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(contentView.safeAreaLayoutGuide).multipliedBy(0.2)
        }
        
        castRealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            make.leading.equalTo(castImage.snp.trailing).offset(20)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(castRealNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(castImage.snp.trailing).offset(20)
        }
        
    }
    
    func configUI(data:Cast) {
      
        
        if let yesImage = data.profile_path {
            let url = URL(string: "https://image.tmdb.org/t/p/h632\(yesImage)")
            castImage.kf.setImage(with: url)
        } else {
            castImage.image = UIImage(systemName: "star")
            castImage.contentMode = .scaleAspectFit
        }
        castImage.layer.borderColor = UIColor.black.cgColor
        castImage.layer.cornerRadius = 4
        castImage.clipsToBounds = true
        
        
        if let yesName = data.original_name {
            castRealNameLabel.text = yesName
        } else {
            castRealNameLabel.text = "정보없음"
        }
        castRealNameLabel.textAlignment = .left
        castRealNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        
        if let yesName2 = data.character {
            characterNameLabel.text = yesName2
        } else {
            characterNameLabel.text = "정보없음"
        }
    
        characterNameLabel.textAlignment = .left
        characterNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        characterNameLabel.textColor = .gray
        
    }
    
    
}
