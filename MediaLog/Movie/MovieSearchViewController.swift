//
//  MovieSearchViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import UIKit

import Alamofire
import SnapKit


class MovieSearchViewController: UIViewController {

    let searchBar = UISearchBar()
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var page = 1
    var list = Movie(page: 1, results: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
     
       
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        
        print(#function)
        
        let layout = UICollectionViewFlowLayout()
        // 전체 화면 너비 - 셀 사이 간격 = 각 셀 너비 * 각 행 셀 갯수 -> itemsize 활용
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width / 3, height: width / 2.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    
    }
  
}

extension MovieSearchViewController {
    
    func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(movieCollectionView)
    }
    
    func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        configureView("영화")
        
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        // prefetch도 datasource 잊지말기!
        movieCollectionView.prefetchDataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        searchBar.delegate = self
        searchBar.placeholder = "영화를 검색해보세요"
        
    
    }
    
    func callRequest(query: String) {
        print(#function)
        
        let url = APIURL.movieURL
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": "application/json"
        ]
        
        let param: Parameters = [
            "query": query,
            "page": page,
            "language": "ko-KR"
        ]
        
        AF.request(url, method: .get,parameters: param,headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Movie.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    
                    if self.page == 1 {
                        self.list = value
                        self.movieCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .top, animated: false)
                    } else {
                        self.list.results.append(contentsOf: value.results)
                    }
                    
                  //  print(self.list)
                    // 리로드 데이터 까먹지 말자..!!!!!!!!!!! 서치바 누르면 쿼리 전달되는 것 확인 -> 응답 성공 확인 -> 값 식판 담기는지 확인 -> 셀 갯수 확인 -> 검색되는데도 계속 0이면 리로드 확인
                    self.movieCollectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        
    }
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(list.results.count)
        return list.results.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let data = list.results[indexPath.row]
        cell.configUI(data: data)
        return cell
    }
    
    
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        callRequest(query: searchBar.text!)
        print(#function)
    }

}

extension MovieSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch \(indexPaths)")
        
        for i in indexPaths {
            if list.results.count - 1 == i.item {
             page += 1
                callRequest(query: searchBar.text!)
            }
        }
    }
    
    
}
