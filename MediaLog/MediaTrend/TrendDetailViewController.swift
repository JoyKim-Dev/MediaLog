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
    
    var dataFromPreviousPage: Result?
    let tableView = UITableView()
    let mainImageView = UIImageView()
    let mainTitleLabel = UILabel()
    
    var imageList: [[Result]] = [[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(mainImageView)
        view.addSubview(mainTitleLabel)
    }
    
    override func configureLayout() {
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
    
    override func configureView() {
        
        configureView("\(dataFromPreviousPage?.displayTitle ?? "미정") ")
        
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarBtnTapped))
        navigationItem.leftBarButtonItem = backBarBtn
        
        mainImageView.backgroundColor = .red
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
    
    @objc func backBarBtnTapped() {
        
        dismiss(animated: true)
    }
    
    func callRequest() {
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.movieData(api: .similarMovie(id: self.dataFromPreviousPage?.id ?? 0)) { movie, error in
                if let error = error {
                    print("에러남\(error)")
                } else {
                    guard let movie = movie else {return}
                    self.imageList[0] = movie
                    print("리스트에 비슷한 영화 정보 데이터 잘 담김-> 여기서 포스터 추출해서 이미지 넣기1")
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.movieData(api: .recommendMovie(id: self.dataFromPreviousPage?.id ?? 0)) { movie, error in
                if let error = error {
                    print("에러남\(error)")
                } else {
                    guard let movie = movie else {return}
                    self.imageList[1] = movie
                    print("리스트에 추천 영화 정보 데이터 잘 담김-> 여기서 포스터 추출해서 이미지 넣기2")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("작업 끝!")
            self.tableView.reloadData()
        }
    }
}

extension TrendDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaCollectionTableViewCell.identifier, for: indexPath) as! MediaCollectionTableViewCell
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.configureView(data: indexPath.row)
        
        return cell
    }
}

extension TrendDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as! ContentsCollectionViewCell
        
        let data = imageList[collectionView.tag][indexPath.item]
        cell.configUI(data: data)
        return cell
    }
}
