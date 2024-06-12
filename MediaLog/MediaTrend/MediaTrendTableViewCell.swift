//
//  MediaTrendTableViewCell.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//

import UIKit

import Kingfisher
import SnapKit


class MediaTrendTableViewCell: UITableViewCell {

    let containerView: UIView = {
        let view = shadowView()
        return view
    }()
    let posterImageview = UIImageView()
    let voteStarImage = UIImageView()
    let voteAverageLabel = UILabel()
    let titleLabel = UILabel()
    let originalTitleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let lineView = UIView()
    let furtherInfoLabel = UILabel()
    let nextBtn = UIButton()
    let saveBtn = UIButton()
    
    lazy var voteStack = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        saveBtn.layer.cornerRadius = saveBtn.frame.width / 2
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      
    }
    
}

extension MediaTrendTableViewCell {
    
    func configHierarchy() {
        contentView.addSubview(containerView)
        contentView.addSubview(nextBtn)
        contentView.addSubview(posterImageview)
        contentView.addSubview(voteStack)
        contentView.addSubview(titleLabel)
        contentView.addSubview(originalTitleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(furtherInfoLabel)
        
        contentView.addSubview(saveBtn)
        
        voteStack.addArrangedSubview(voteStarImage)
        voteStack.addArrangedSubview(voteAverageLabel)
    }
    
    func configLayout() {
        
       
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(25)
        }
        
        voteStack.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(25)
        }
        posterImageview.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(containerView)
            make.bottom.equalTo(titleLabel.snp.top).offset(-20)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.trailing.equalTo(posterImageview).inset(15)
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(originalTitleLabel.snp.top).offset(-5)
            make.leading.equalTo(containerView).inset(15)
        }
      
        originalTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(lineView.snp.top).offset(-14)
            make.horizontalEdges.equalTo(containerView).inset(15)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(containerView).inset(15)
            make.bottom.equalTo(furtherInfoLabel.snp.top).offset(-14)
        }
        
        furtherInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(containerView).offset(-15)
            make.leading.equalTo(containerView).inset(15)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(containerView).inset(15)
            make.trailing.equalTo(containerView).inset(10)
            make.height.width.equalTo(furtherInfoLabel.snp.height)
        }
        
    }
    
    func configUI(data: Result) {

        contentView.backgroundColor = .white
     
        let url = URL(string: "https://image.tmdb.org/t/p/w1280\(data.backdrop_path)")
        posterImageview.kf.setImage(with: url)
        posterImageview.contentMode = .scaleToFill
        
        saveBtn.setImage(UIImage(systemName: "paperclip"), for: .normal)
        saveBtn.backgroundColor = .white
        saveBtn.layer.cornerRadius = saveBtn.frame.width / 2
        saveBtn.layer.masksToBounds = true
        
        
        voteStarImage.image = UIImage(systemName: "star.fill")
        voteStarImage.tintColor = Constant.Color.redAccentBtn
        
        voteAverageLabel.text = String(data.vote_average.rounded())
        voteAverageLabel.font = .boldSystemFont(ofSize: 13)
        
        
        releaseDateLabel.text = "개봉일: \(data.displayDate ?? "미정")"
        releaseDateLabel.font = Constant.Font.defaultRegular13
        releaseDateLabel.textColor = Constant.TextColor.defaultBlack
        

        titleLabel.text = data.displayTitle
        titleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        titleLabel.textColor = Constant.TextColor.defaultBlack
        titleLabel.textAlignment = .left
        
        
        originalTitleLabel.text = data.displayOriginalTitle
        originalTitleLabel.font = Constant.Font.bold14
        originalTitleLabel.textColor = Constant.TextColor.softGray
        originalTitleLabel.textAlignment = .left
        
        lineView.backgroundColor = Constant.Color.GrayLineBg
        
        furtherInfoLabel.text = "자세히 보기"
        furtherInfoLabel.textColor = Constant.TextColor.defaultBlack
        furtherInfoLabel.textAlignment = .left
        furtherInfoLabel.font = Constant.Font.defaultRegular13
        
        nextBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextBtn.tintColor = Constant.Color.blackDefaultBtn
        
        voteStack.axis = .horizontal
        voteStack.spacing = 5
        voteStack.distribution = .fill
        
        voteAverageLabel.textAlignment = .right
        
    }
   
}


