//
//  MovieHomeViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/27/24.
//

import UIKit
import MapKit

final class MovieHomeViewController: BaseViewController {
    
    private let tableView = UITableView()
    private var movieList: [Media] = [Media(page: 1, results: []), Media(page: 1, results: []), Media(page: 1, results: [])]
    
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
        configureView("MOVIE HOME")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 260
        tableView.register(MovieHomeTableViewCell.self, forCellReuseIdentifier: MovieHomeTableViewCell.identifier)
    }
}

extension MovieHomeViewController {
    
    private func dispatchGroupCallRequest() {
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.nowPlayingCallRequest()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.upcomingMovieCallRequest()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.movieTrendCallRequest()
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    
    private func nowPlayingCallRequest() {
        NetworkManager.shared.request(api: .nowPlayingMovie, model: Media.self) { movie, error in
            if let error = error {
                print("나우플레잉 에러\(error)")
            } else {
                guard let movie = movie else {return}
                self.movieList[0] = movie
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func upcomingMovieCallRequest() {
        NetworkManager.shared.allMovieData(api: .upcomingMovie) { movie, error in
            if let error = error {
                print("업커밍 에러\(error)")
            } else {
                guard let movie = movie else {return}
                self.movieList[1] = movie
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    private func movieTrendCallRequest() {
        NetworkManager.shared.allMovieData(api: .trendingMovie(time: .day)) { movie, error in
            if let error = error {
                print("올무비 에러\(error)")
            } else {
                guard let movie = movie else {return}
                self.movieList[2] = movie
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TrendDetailViewController()
        vc.dataFromPreviousPage = movieList[collectionView.tag].results[indexPath.item]
      present(vc, animated: true)

    }
}

