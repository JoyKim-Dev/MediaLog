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
    let youtubeLinkButton = UIButton()
    
    lazy var url = URL(string: "https://image.tmdb.org/t/p/w1280\(dataFromPreviousPage?.backdrop_path ?? "미정")")
    var dataFromPreviousPage: Result?
    var movieData = Media(page: 0, results: [])
    var castData = CastInfo(id: 0, cast: [])
    var videoData: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarBtnTapped))
        navigationItem.leftBarButtonItem = backBarBtn
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaCollectionTableViewCell.self, forCellReuseIdentifier: MediaCollectionTableViewCell.identifier)
        tableView.register(MovieOverviewTableViewCell.self, forCellReuseIdentifier: MovieOverviewTableViewCell.identifier)
        dispatchGroupCallRequest()
    }
    
    override func configHierarchy() {
        print(#function)
        view.addSubview(tableView)
        view.addSubview(mainImageView)
        view.addSubview(mainTitleLabel)
        view.addSubview(youtubeLinkButton)
    }
    
    override func configLayout() {
        print(#function)
        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(220)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.top.width.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        youtubeLinkButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(mainImageView).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        print(#function)
        
        configureView("\(dataFromPreviousPage?.displayTitle ?? "미정") ")
        
        mainImageView.kf.setImage(with: url)
        mainTitleLabel.text = dataFromPreviousPage?.displayOriginalTitle
        mainTitleLabel.font = .systemFont(ofSize: 22, weight: .heavy)
        mainTitleLabel.textColor = .white
        
        youtubeLinkButton.setTitleColor(.white, for: .normal)
        youtubeLinkButton.setTitle("YouTube", for: .normal)
        youtubeLinkButton.titleLabel?.font = Font.heavy20forTitle
        youtubeLinkButton.backgroundColor = .red
        youtubeLinkButton.layer.cornerRadius = 10
        youtubeLinkButton.clipsToBounds = true
        youtubeLinkButton.addTarget(self, action: #selector(youtubeBtnTapped), for: .touchUpInside)
    }
    
    
}
extension TrendDetailViewController {
    
    @objc func backBarBtnTapped() {
        
        dismiss(animated: true)
    }
    
    @objc func youtubeBtnTapped() {
        let vc = YoutubeWebViewController()
        guard let videoData = videoData else {return}
        vc.receivedMovieURL = videoData
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
    
    func dispatchGroupCallRequest() {
        print(#function)
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.similarMovieCallRequest()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.castCallRequest()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.trailerVideoCallRequest()
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    
    func similarMovieCallRequest() {
        print(#function)
        NetworkManager.shared.request(api: .similarMovie(id: (self.dataFromPreviousPage?.id)!), model: Media.self) { movie, error in
            if error != nil {
                print("시밀러무비정보없음")
            } else {
                guard let movie = movie else {return}
                self.movieData = movie
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func castCallRequest() {
        print(#function)
        NetworkManager.shared.castData(api: .movieCast(id: (dataFromPreviousPage?.id)!)) { cast, error in
            if error != nil {
                print("캐스트정보 없음")
                
            } else {
                guard let cast = cast else {return}
                self.castData = cast
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func trailerVideoCallRequest() {
        print(#function)
        guard let id = dataFromPreviousPage?.id else { return}
        
        NetworkManager.shared.request(api: .movieTrailerVideo(id: id), model: Video.self) { video, error in
            if error != nil {
                print("id 없음")
            } else {
                guard let video = video?.results[0].key else {return}
                print(video)
                self.videoData = "https://www.youtube.com/watch?v=\(video)"
            }
        }
    }
}

extension TrendDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)
        if indexPath.row == 0 {
            return 200
        } else {
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let data = dataFromPreviousPage else {
            print("데이터에러")
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieOverviewTableViewCell.identifier, for: indexPath) as! MovieOverviewTableViewCell
            
            cell.configUI(data: data)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaCollectionTableViewCell.identifier, for: indexPath) as! MediaCollectionTableViewCell
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.row
            cell.configureView(data: indexPath.row)
            cell.collectionView.reloadData()
            return cell
        }
    }
}

extension TrendDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        if collectionView.tag == 1 {
            print("\(castData.cast.count)명")
            return castData.cast.count
        } else {
            return movieData.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as! ContentsCollectionViewCell
        if collectionView.tag == 1 {
            let castData = castData.cast[indexPath.item]
        } else {
            let movieData = movieData.results[indexPath.item]
        }
        cell.configUI(movieData: movieData, castData: castData, indexPath: indexPath, tableViewRow: collectionView.tag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            let vc = TrendDetailViewController()
            vc.dataFromPreviousPage = movieData.results[indexPath.item]
            present(vc, animated: true)
        }
    }
}

