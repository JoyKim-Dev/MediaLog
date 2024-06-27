////
////  RecomContentsInfo.swift
////  MediaLog
////
////  Created by Joy Kim on 6/24/24.
////
//import UIKit
//import Kingfisher
//
//class MediaImageTableViewCell: UITableViewCell {
//    
//    let mainImageView = UIImageView()
//    let backdropImageView = UIImageView()
//    let originalTitleLabel = UILabel()
//    let overViewLabel = UILabel()
//    let overViewDetailLabel = UILabel()
//    let lineView = UIView()
//    let overViewBtn = UIButton()
//      
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        configureHierarchy()
//        configureLayout()
//      
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension MediaImageTableViewCell {
//    
//    func configureHierarchy() {
//        contentView.addSubview(backdropImageView)
//        contentView.addSubview(mainImageView)
//        contentView.addSubview(originalTitleLabel)
//        contentView.addSubview(overViewLabel)
//        contentView.addSubview(overViewDetailLabel)
//        contentView.addSubview(lineView)
//        contentView.addSubview(overViewBtn)
//    }
//    
//    func configureLayout() {
//        backdropImageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
//            make.height.equalTo(250)
//            make.width.equalTo(contentView.safeAreaLayoutGuide)
//        }
//        
//        originalTitleLabel.snp.makeConstraints { make in
//            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
//        }
//        
//        mainImageView.snp.makeConstraints { make in
//            make.bottom.equalTo(backdropImageView)
//            make.leading.equalTo(originalTitleLabel)
//            make.width.equalTo(backdropImageView).multipliedBy(0.3)
//            make.height.equalTo(mainImageView.snp.width).multipliedBy(1.5)
//            make.top.equalTo(originalTitleLabel.snp.bottom).offset(10)
//        }
//        
//        overViewLabel.snp.makeConstraints { make in
//            make.top.equalTo(backdropImageView.snp.bottom).offset(25)
//            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
//        }
//        
//        lineView.snp.makeConstraints { make in
//            make.height.equalTo(0.2)
//            make.leading.equalTo(contentView.safeAreaInsets).inset(15)
//            make.trailing.equalTo(contentView)
//            make.top.equalTo(overViewLabel.snp.bottom).offset(3)
//        }
//        
//        overViewDetailLabel.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.bottom).offset(15)
//            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
//            make.bottom.lessThanOrEqualTo(contentView).offset(-20)
//        }
//        
//        overViewBtn.snp.makeConstraints { make in
//            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
//            make.top.equalTo(overViewDetailLabel.snp.bottom).offset(5)
//        }
//    }
//    
//    func configureView(dataFromPreviousPage: Result? ) {
//        
//        guard let data = dataFromPreviousPage else {
//            return
//        }
//        let url = URL(string: "https://image.tmdb.org/t/p/w1280\(data.backdrop_path)")
//        backdropImageView.kf.setImage(with: url)
//        backdropImageView.contentMode = .scaleAspectFill
//        
//        let url2 = URL(string: "https://image.tmdb.org/t/p/w780\(data.poster_path)")
//        mainImageView.kf.setImage(with: url2)
//        mainImageView.backgroundColor = .red
//        
//        originalTitleLabel.text = data.displayOriginalTitle
//        originalTitleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
//        originalTitleLabel.textColor = Constant.TextColor.darkBGWhite
//        originalTitleLabel.textAlignment = .left
//        
//        overViewLabel.text = "OverView"
//        overViewLabel.font = .boldSystemFont(ofSize: 15)
//        overViewLabel.textColor = Constant.TextColor.softGray
//        overViewLabel.textAlignment = .left
//        overViewBtn.addTarget(self, action: #selector(overViewBtnTapped), for: .touchUpInside)
//        
//        lineView.backgroundColor = Constant.Color.GrayLineBg
//        
//        overViewDetailLabel.text = data.overview
//        overViewDetailLabel.font = .systemFont(ofSize: 15, weight: .regular)
//        overViewDetailLabel.textColor = Constant.TextColor.defaultBlack
//        overViewDetailLabel.textAlignment = .center
//        overViewDetailLabel.numberOfLines = 2
//        
//        
//        overViewBtn.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
//        overViewBtn.tintColor = .gray
//    }
//    @objc func overViewBtnTapped() {
//    
//            if overViewDetailLabel.numberOfLines == 2 {
//                overViewDetailLabel.numberOfLines = 0
//                overViewBtn.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
//            } else {
//    
//                overViewDetailLabel.numberOfLines = 2
//                overViewBtn.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
//            }
//    
//            contentView.layoutIfNeeded()
//        }
//}
//
