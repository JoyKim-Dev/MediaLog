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
        callRequest()
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
//        view.backgroundColor = .white
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        mediaTableView.rowHeight = 400
        mediaTableView.register(MediaTrendTableViewCell.self, forCellReuseIdentifier: MediaTrendTableViewCell.identifier)
        
//        navigationItem.title = "MEDIA TREND"
     
        
        
        let listBarbtn = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftListBtnTapped))
        navigationItem.leftBarButtonItem = listBarbtn
        
        let searchBarBtn = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBarbtnTapped))
        navigationItem.rightBarButtonItem = searchBarBtn
        
    }
    
    func callRequest() {
        print(#function)
        
        let url = APIURL.movieURL
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
                      "accept": "application/json"
        ]
        
        let param: Parameters = ["language": "ko-KR"]
        
        AF.request(url, method: .get, parameters: param, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Media.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
            case .success(let value):
                print("SUCCESS")
                    self.list = value.results
                    self.mediaTableView.reloadData()
                    print("값리로드완료")
            case .failure(let error):
                print(error)
        
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
        print(list.count)
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
        let vc = MovieDetailViewController()
        
        vc.dataFromPreviousPage = data
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }

    
}
