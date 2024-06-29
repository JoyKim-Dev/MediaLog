//
//  MovieHomeViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/27/24.
//

import UIKit
import MapKit

class MovieHomeViewController: BaseViewController {
    
    let tableView = UITableView()
    var movieList: [Media] = [Media(page: 1, results: []), Media(page: 1, results: []), Media(page: 1, results: [])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       dispatchGroupCallRequest()

    }
    
    override func configHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        configureView("MOVIE LOG")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 260
        tableView.register(MovieHomeTableViewCell.self, forCellReuseIdentifier: MovieHomeTableViewCell.identifier)
    }
}

extension MovieHomeViewController {
    
    func dispatchGroupCallRequest() {
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.nowPlayingCallRequest()
        }
        group.leave()
        
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.upcomingMovieCallRequest()
        }
        group.leave()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.movieTrendCallRequest()
        }
        group.leave()
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    
    func nowPlayingCallRequest() {
        NetworkManager.shared.request(api: .nowPlayingMovie, model: Media.self) { movie, error in
            if let error = error {
                print("나우플레잉 에러\(error)")
            } else {
                guard let movie = movie else {return}
                self.movieList[0] = movie
            }
        }
    }
    
    func upcomingMovieCallRequest() {
        NetworkManager.shared.allMovieData(api: .upcomingMovie) { movie, error in
            if let error = error {
                print("업커밍 에러\(error)")
            } else {
                guard let movie = movie else {return}
                self.movieList[1] = movie
                print("업커밍==========================================")
                
            }
            }
        }
    
    func movieTrendCallRequest() {
        NetworkManager.shared.allMovieData(api: .trendingMovie(time: .day)) { movie, error in
            if let error = error {
                print("올무비 에러\(error)")
            } else {
                guard let movie = movie else {return}
                self.movieList[2] = movie
                print("트렌드================================================")
                
            }
        }
    }
}

extension MovieHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieHomeTableViewCell.identifier, for: indexPath) as! MovieHomeTableViewCell
        
        cell.configUI(data: indexPath)
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(MovieHomeCollectionViewCell.self, forCellWithReuseIdentifier: MovieHomeCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        return cell
        
    }
   
}

extension MovieHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList[collectionView.tag].results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieHomeCollectionViewCell.identifier, for: indexPath) as! MovieHomeCollectionViewCell
        
        let data = movieList[collectionView.tag].results[indexPath.item]
        cell.configUI(data: data)
       
    
        return cell
    }
}

