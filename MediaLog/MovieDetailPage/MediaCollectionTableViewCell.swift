//
//  MediaCollectionTableViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/25/24.
//

import UIKit

final class MediaCollectionTableViewCell: UITableViewCell {

    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.textColor = .black
        return view
    }()
    
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
     func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.horizontalEdges.top.equalTo(contentView).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
     func configureView(data: Int) {
    
        titleLabel.font = Font.semiBold16forSubLable
        
        if data == 1 {
            titleLabel.text = "출연진"
        } else if data == 2 {
            titleLabel.text = "비슷한 영화"
        }
    }
}
    
