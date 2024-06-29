//
//  MovieHomeTableViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/29/24.
//

import UIKit
import SnapKit

class MovieHomeTableViewCell: BaseTableViewCell {
    
    let titleLable = UILabel()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configHierarchy() {
        contentView.addSubview(titleLable)
        contentView.addSubview(collectionView)
    }
    
    override func configLayout() {
        titleLable.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configUI(data: IndexPath) {
        super.configUI()
        titleLable.font = Font.semiBold16forSubLable
        titleLable.textColor = Color.blackForBasicText
        if data.row == 0 {
            titleLable.text = "Now Playing 현재상영작"
        } else if data.row == 1 {
            titleLable.text = "Upcoming Movie 상영예정작"
        } else {
            titleLable.text = "Movie Trend 최신트렌드"
        }
    }
    
}

extension MovieHomeTableViewCell {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height:210)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        return layout
        
    }
}
