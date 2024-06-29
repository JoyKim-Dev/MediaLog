//
//  TrendDetailViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/25/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class TrendDetailViewController: BaseViewController {
    
    
    let tableView = UITableView()
    let mainImageView = UIImageView()
    let mainTitleLabel = UILabel()
    
    var dataFromPreviousPage: Result?
    var movieData = Media(page: 0, results: [])
    var castData = CastInfo(id: 0, cast: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatchGroupCallRequest()
    }
    
    override func configHierarchy() {
        view.addSubview(tableView)
        view.addSubview(mainImageView)
        view.addSubview(mainTitleLabel)
    }
    
    override func configLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(220)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.top.width.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        
        configureView("\(dataFromPreviousPage?.displayTitle ?? "미정") ")
        
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarBtnTapped))
        navigationItem.leftBarButtonItem = backBarBtn
        
        let url = URL(string: "https://image.tmdb.org/t/p/w1280\(dataFromPreviousPage?.backdrop_path ?? "미정")")
        mainImageView.kf.setImage(with: url)
        mainTitleLabel.text = dataFromPreviousPage?.displayOriginalTitle
        mainTitleLabel.font = .systemFont(ofSize: 22, weight: .heavy)
        mainTitleLabel.textColor = .white
        
        tableView.rowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaCollectionTableViewCell.self, forCellReuseIdentifier: MediaCollectionTableViewCell.identifier)
    }
    
    
}

extension TrendDetailViewController {
    
    @objc func backBarBtnTapped() {
        
        dismiss(animated: true)
    }
    
    func dispatchGroupCallRequest() {
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.similarMovieCallRequest()
        }
        group.leave()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.castCallRequest()
        }
        group.leave()
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    
    func similarMovieCallRequest() {
        
        NetworkManager.shared.request(api: .similarMovie(id: (self.dataFromPreviousPage?.id)!), model: Media.self) { movie, error in
            if error != nil {
                guard let movie = movie else {return}
                self.movieData = movie
            } else {
                print("시밀러무비정보없음")
            }
        }
    }
    
    func castCallRequest() {
        
        NetworkManager.shared.castData(api: .movieCast(id: (dataFromPreviousPage?.id)!)) { cast, error in
            if error != nil {
                guard let cast = cast else {return}
                self.castData = cast
            } else {
                print("캐스트정보 없음")
            }
        }
    }
}

extension TrendDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaCollectionTableViewCell.identifier, for: indexPath) as! MediaCollectionTableViewCell
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        cell.configureView(data: indexPath.row)
        
        return cell
    }
}

extension TrendDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as! ContentsCollectionViewCell
        
        let data = movieData.results[indexPath.item]
        cell.configUI(data: data)
        return cell
    }
}
