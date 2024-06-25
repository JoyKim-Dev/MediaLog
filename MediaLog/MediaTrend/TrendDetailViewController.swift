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
    
    var imageList: [[SimilarResult]] = [[],[]]
    
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
        print(#function)
        
        let group = DispatchGroup() // + 1
        
        group.enter() // 작업량 + 1
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.similarMovie(id: self.dataFromPreviousPage?.id ?? 0) { data in
                self.imageList[0] = data
                print("시밀러 네트워킹")
                group.leave()
            }
        }
        group.enter() // 작업량 + 1
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.recommendMovie(id: self.dataFromPreviousPage?.id ?? 0) { data in
                self.imageList[1] = data
                group.leave() // - 1
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
            print("통신 마치고 리스트 업데이트함")
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
