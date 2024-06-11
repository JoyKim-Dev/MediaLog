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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
        callRequest()
       
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
        
        movieCollectionView.backgroundColor = .blue
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    func callRequest() {
        
        
    }
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
    
    
    
}
