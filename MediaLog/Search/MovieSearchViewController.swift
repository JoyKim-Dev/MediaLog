//
//  MovieSearchViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import UIKit

import Alamofire
import SnapKit


final class MovieSearchViewController: UIViewController {

    private let searchBar = UISearchBar()
    private lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private var page = 1
    private var list = Media(page: 1, results: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
    }
        

    private func collectionViewLayout() -> UICollectionViewLayout {
        
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
    
    private func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(movieCollectionView)
    }
    
    private func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configUI() {
        configureView("SEARCH MOVIE")
        
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        // prefetch도 datasource 잊지말기!
        movieCollectionView.prefetchDataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        searchBar.delegate = self
        searchBar.placeholder = "영화를 검색해보세요"
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
                   tap.cancelsTouchesInView = false
                   view.addGestureRecognizer(tap)
    }
    
    private func callRequest(query: String) {
        print(#function)
        
        NetworkManager.shared.allMovieData(api: .movieList(query: searchBar.text ?? "미정", page: page)) { movie, error in
            
            if error != nil {
                print("에러 발생")
            } else {
                guard let movie = movie else {return}
                
                if self.page == 1 {
                    self.list = movie
                    self.movieCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .top, animated: false)
                } else {
                    self.list.results.append(contentsOf: movie.results)
                }

                self.movieCollectionView.reloadData()
                print("데이터 잘 담아짐 리스트에")
            }
        }
    }
    
    private func dismissKeyboard(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TrendDetailViewController()
        vc.dataFromPreviousPage = list.results[indexPath.item]
        present(vc, animated: true)

    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard(searchBar)
        page = 1
        callRequest(query: searchBar.text!)
        print(#function)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
dismissKeyboard(searchBar)
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
