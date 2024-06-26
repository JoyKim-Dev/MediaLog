//
//  MediaTrendViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class MediaTrendViewController: UIViewController {
    
    let mediaTableView = UITableView()
    var list: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
        callRequest() //무비 트렌드 데이터 받아오기

    }
}

extension MediaTrendViewController {
    
    func configHierarchy() {
        view.addSubview(mediaTableView)
    }
    
    func configLayout() {
        mediaTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        configureView("MEDIA TREND")
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        mediaTableView.rowHeight = 400
        mediaTableView.register(MediaTrendTableViewCell.self, forCellReuseIdentifier: MediaTrendTableViewCell.identifier)
  
        let listBarbtn = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftListBtnTapped))
        navigationItem.leftBarButtonItem = listBarbtn
        
        let searchBarBtn = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBarbtnTapped))
        navigationItem.rightBarButtonItem = searchBarBtn
        
    }
    
    func callRequest() {
        NetworkManager.shared.movieData(api: .trendingMovie(time: .day)) { movie, error in
           
            if let error = error {
                print("에러남\(error)")
            } else {
                guard let movie = movie else {return}
                self.list = movie
                self.mediaTableView.reloadData()
                print("리스트에 무비 트렌드 데이터 잘 담김")
                dump(movie)
            }
        }
    }
    

    @objc func leftListBtnTapped() {
    }
    @objc func searchBarbtnTapped() {
    }
  
}

extension MediaTrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("셀\(list.count)개")
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mediaTableView.dequeueReusableCell(withIdentifier: MediaTrendTableViewCell.identifier, for: indexPath) as! MediaTrendTableViewCell
        
        let data = list[indexPath.row]
        cell.configUI(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let vc = TrendDetailViewController()
        
        vc.dataFromPreviousPage = data
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
  
}
