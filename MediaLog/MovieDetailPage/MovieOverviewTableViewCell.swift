//
//  MovieOverviewTableViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/29/24.
//

import UIKit
import SnapKit

final class MovieOverviewTableViewCell: BaseTableViewCell {
    
    let mainLabel = UILabel()
    let lineView = UIView()
    let overViewTextLabel = UILabel()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configHierarchy() {
        contentView.addSubview(mainLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(overViewTextLabel)
    }
    
    override func configLayout() {
        mainLabel.snp.makeConstraints { make in
            make.width.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(mainLabel.snp.bottom).offset(2)
            make.width.equalTo(100)
            make.centerX.equalTo(contentView)
        }
        
        overViewTextLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(contentView).inset(20)
        }
    }
    
    func configUI(data: Result) {
        
        mainLabel.text = "OverView"
        mainLabel.textAlignment = .center
        mainLabel.font = Font.semiBold14forBasicInfo
        lineView.backgroundColor = Color.mainPurple
        
        overViewTextLabel.text = data.overview
        overViewTextLabel.numberOfLines = 0
        overViewTextLabel.font = Font.semiBold14forBasicInfo
        overViewTextLabel.textAlignment = .natural
    }
}



