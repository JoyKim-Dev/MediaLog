//
//  MovieDetailViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    var dataFromPreviousPage: Result?
    var castInfo = CastInfo(id: 0, cast: [])
    
    let mainImageView = UIImageView()
    let backdropImageView = UIImageView()
    let originalTitleLabel = UILabel()
    let overViewLabel = UILabel()
    let overViewDetailLabel = UILabel()
    let lineView = UIView()
    let overViewBtn = UIButton()
    let castTableView = UITableView()
    let castTitleLabel = UILabel()
    let castLineView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configHierarchy()
        configLayout()
        configUI()
        callRequest()
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
        view.addSubview(overViewBtn)
        view.addSubview(castTitleLabel)
        view.addSubview(castLineView)
        view.addSubview(castTableView)
        
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
        
        overViewBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(overViewDetailLabel.snp.bottom).offset(5)
        }
  
        castTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(overViewBtn.snp.bottom).offset(3)
        }
        
        castLineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaInsets).inset(15)
            make.trailing.equalTo(view)
            make.top.equalTo(castTitleLabel.snp.bottom).offset(3)
        }
        
        castTableView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(castLineView.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
     
        
    }
    
    func configUI() {
        view.backgroundColor = .white
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(MediaDetailCastTableViewCell.self, forCellReuseIdentifier: MediaDetailCastTableViewCell.identifier)
        castTableView.rowHeight = 120
        
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
        overViewDetailLabel.numberOfLines = 2
        
        
        overViewBtn.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        overViewBtn.tintColor = .gray
        overViewBtn.addTarget(self, action: #selector(overViewBtnTapped), for: .touchUpInside)
        
        
        castTitleLabel.text = "Cast"
        castTitleLabel.textColor = .gray
        castTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        castLineView.backgroundColor = .gray
       
        
    }
    
    func callRequest() {
        
        
        let url = APIURL.movieCastURL(id: dataFromPreviousPage?.id ?? 0)
        print(url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": "application/json"
        ]
        let param:Parameters = ["language": "ko-KR"]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
//            .responseString { response in
//                dump(response)
//            }
            .responseDecodable(of: CastInfo.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    
                    self.castInfo = value
                    self.castTableView.reloadData()
                    
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        
        
    }
    
    @objc func backBarBtnTapped() {
        
        dismiss(animated: true)
    }
    
    @objc func overViewBtnTapped() {
        
        if overViewDetailLabel.numberOfLines == 2 {
            overViewDetailLabel.numberOfLines = 0
            overViewBtn.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
        } else {
            
            overViewDetailLabel.numberOfLines = 2
            overViewBtn.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        }
        
        view.layoutIfNeeded()
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("셀갯수: \(castInfo.cast.count)")
       return castInfo.cast.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castTableView.dequeueReusableCell(withIdentifier: MediaDetailCastTableViewCell.identifier, for: indexPath) as! MediaDetailCastTableViewCell
        
      cell.configUI(data: castInfo.cast[indexPath.row])
        
        return cell
    }
    
    
    
    
}
