//
//  MovieDetailViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//

import UIKit

import SnapKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    var dataFromPreviousPage: Result?
    
    let mainImageView = UIImageView()
    let backdropImageView = UIImageView()
    let originalTitleLabel = UILabel()
    let overViewLabel = UILabel()
    let overViewDetailLabel = UILabel()
    let lineView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configHierarchy()
        configLayout()
        configUI()
    }
    
}

extension MovieDetailViewController {
    
    func configHierarchy() {
        
        view.addSubview(backdropImageView)
        view.addSubview(mainImageView)
        view.addSubview(originalTitleLabel)
        view.addSubview(overViewLabel)
        view.addSubview(overViewDetailLabel)
        view.addSubview(lineView)
    }
    
    func configLayout() {
        
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(backdropImageView).inset(20)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.bottom.equalTo(backdropImageView)
            make.leading.equalTo(originalTitleLabel)
            make.width.equalTo(backdropImageView).multipliedBy(0.25)
            make.top.equalTo(originalTitleLabel.snp.bottom).offset(10)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.2)
            make.leading.equalTo(view.safeAreaInsets).inset(15)
            make.trailing.equalTo(view)
            make.top.equalTo(overViewLabel.snp.bottom).offset(3)
        }
        
        overViewDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.lessThanOrEqualTo(view).offset(-20)
        }
        
        
    }
    
    func configUI() {
        view.backgroundColor = .white
        navigationItem.title = dataFromPreviousPage?.displayTitle
        
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarBtnTapped))
        navigationItem.leftBarButtonItem = backBarBtn
        
        let url = URL(string: "https://image.tmdb.org/t/p/w1280\(dataFromPreviousPage!.backdrop_path)")
        print(dataFromPreviousPage?.backdrop_path ?? "nil")
        backdropImageView.kf.setImage(with: url)
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.backgroundColor = .blue
        
        let url2 = URL(string: "https://image.tmdb.org/t/p/w780\(dataFromPreviousPage!.poster_path)")
        print(dataFromPreviousPage?.poster_path ?? "nil")
        mainImageView.kf.setImage(with: url2)
        mainImageView.backgroundColor = .systemPink
        
        originalTitleLabel.text = dataFromPreviousPage?.displayOriginalTitle
        originalTitleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        originalTitleLabel.textColor = .white
        originalTitleLabel.textAlignment = .left
        
        overViewLabel.text = "OverView"
        overViewLabel.font = .boldSystemFont(ofSize: 15)
        overViewLabel.textColor = .gray
        overViewLabel.textAlignment = .left
        
        
        lineView.backgroundColor = .gray
        
        overViewDetailLabel.text = dataFromPreviousPage?.overview
        overViewDetailLabel.font = .systemFont(ofSize: 15, weight: .regular)
        overViewDetailLabel.textColor = .black
        overViewDetailLabel.textAlignment = .center
        overViewDetailLabel.numberOfLines = 0
        
    
        
        
        
    }
    
    @objc func backBarBtnTapped() {
        
        dismiss(animated: true)
    }
}
