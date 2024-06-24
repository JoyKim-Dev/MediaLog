//
//  MovieDetailViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/10/24.
//
// 문제점 : 섹션마다 별도의 스크롤이 적용 안됨 / 헤더뷰가 보여지지 않음 / 스크롤뷰가 작동되지 않아 캐스트 테이블뷰가 가려짐 ㅠㅠ


import UIKit

import Alamofire
import SnapKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    var dataFromPreviousPage: Result?
    var castInfo = CastInfo(id: 0, cast: [])
    var similarInfo = Similar(page: 0, results: [])
    var recomInfo = Recom(page: 0, results: [])
    
    let scrollView = UIScrollView()
    let contentsView = UIView()
    let mainImageView = UIImageView()
    let backdropImageView = UIImageView()
    let originalTitleLabel = UILabel()
    let overViewLabel = UILabel()
    let overViewDetailLabel = UILabel()
    let lineView = UIView()
    let overViewBtn = UIButton()
    lazy var contentsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let castTableView = UITableView()
    let castTitleLabel = UILabel()
    let castLineView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configHierarchy()
        configLayout()
        configUI()
        callRequest()
        callRequestForSimilarMovie()
        callRequestForRecomMovie()
    }
    
}

extension MovieDetailViewController {
    
    func configHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentsView)
       
        
        contentsView.addSubview(backdropImageView)
        contentsView.addSubview(mainImageView)
        contentsView.addSubview(originalTitleLabel)
        contentsView.addSubview(overViewLabel)
        contentsView.addSubview(overViewDetailLabel)
        contentsView.addSubview(lineView)
        contentsView.addSubview(overViewBtn)
        contentsView.addSubview(contentsCollectionView)
        contentsView.addSubview(castTitleLabel)
        contentsView.addSubview(castLineView)
        contentsView.addSubview(castTableView)
        
    }
    
    func configLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(view)
            make.width.equalTo(view)
        }
        
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(backdropImageView).inset(20)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.bottom.equalTo(backdropImageView)
            make.leading.equalTo(originalTitleLabel)
            make.width.equalTo(backdropImageView).multipliedBy(0.25)
            make.top.equalTo(originalTitleLabel.snp.bottom).offset(10)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.2)
            make.leading.equalTo(view.safeAreaInsets).inset(15)
            make.trailing.equalTo(view)
            make.top.equalTo(overViewLabel.snp.bottom).offset(3)
        }
        
        overViewDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
           make.bottom.lessThanOrEqualTo(view).offset(-20)
        }
        
        overViewBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(overViewDetailLabel.snp.bottom).offset(5)
        }
        
        contentsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(overViewBtn.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }

        castTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(contentsCollectionView.snp.bottom).offset(3)
        }
        
        castLineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaInsets).inset(15)
            make.trailing.equalTo(view)
            make.top.equalTo(castTitleLabel.snp.bottom).offset(3)
        }
        
        castTableView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(castLineView.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configUI() {
        view.backgroundColor = .white
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(MediaDetailCastTableViewCell.self, forCellReuseIdentifier: MediaDetailCastTableViewCell.identifier)
        castTableView.rowHeight = 120
        
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        contentsCollectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
        contentsCollectionView.register(CustomCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier)
        
        contentsCollectionView.backgroundColor = .blue
        
        navigationItem.title = dataFromPreviousPage?.displayTitle
        
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarBtnTapped))
        navigationItem.leftBarButtonItem = backBarBtn
        
        let url = URL(string: "https://image.tmdb.org/t/p/w1280\(dataFromPreviousPage!.backdrop_path)")
        print(dataFromPreviousPage?.backdrop_path ?? "nil")
        backdropImageView.kf.setImage(with: url)
        backdropImageView.contentMode = .scaleAspectFill
    
        
        let url2 = URL(string: "https://image.tmdb.org/t/p/w780\(dataFromPreviousPage!.poster_path)")
        print(dataFromPreviousPage?.poster_path ?? "nil")
        mainImageView.kf.setImage(with: url2)
     
        
        originalTitleLabel.text = dataFromPreviousPage?.displayOriginalTitle
        originalTitleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        originalTitleLabel.textColor = Constant.TextColor.darkBGWhite
        originalTitleLabel.textAlignment = .left
        
        overViewLabel.text = "OverView"
        overViewLabel.font = .boldSystemFont(ofSize: 15)
        overViewLabel.textColor = Constant.TextColor.softGray
        overViewLabel.textAlignment = .left
        
        
        lineView.backgroundColor = Constant.Color.GrayLineBg
        
        overViewDetailLabel.text = dataFromPreviousPage?.overview
        overViewDetailLabel.font = .systemFont(ofSize: 15, weight: .regular)
        overViewDetailLabel.textColor = Constant.TextColor.defaultBlack
        overViewDetailLabel.textAlignment = .center
        overViewDetailLabel.numberOfLines = 2
        
        
        overViewBtn.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        overViewBtn.tintColor = .gray
        overViewBtn.addTarget(self, action: #selector(overViewBtnTapped), for: .touchUpInside)
        
        
        castTitleLabel.text = "Cast"
        castTitleLabel.textColor = Constant.TextColor.softGray
        castTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        castLineView.backgroundColor = Constant.Color.GrayLineBg
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing:CGFloat = 2
        let cellSpacing:CGFloat = 4

        layout.itemSize = CGSize(width: 100, height: 140)
        layout.scrollDirection = .horizontal

        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    func callRequest() {
        
        
        let url = APIURL.movieCastURL(id: dataFromPreviousPage?.id ?? 0)
        print(url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": APIResponseStyle.tmdbJson
        ]
        let param:Parameters = ["language": APILanguage.tmdbKorean]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
//            .responseString { response in
//                dump(response)
//            }
            .responseDecodable(of: CastInfo.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    
                    self.castInfo = value
                    self.castTableView.reloadData()
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callRequestForSimilarMovie() {
 
        let url = APIURL.similarMovieURL(id: dataFromPreviousPage?.id ?? 0)
        print(url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": APIResponseStyle.tmdbJson
        ]
        let param:Parameters = ["language": APILanguage.tmdbKorean]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
//            .responseString { response in
//                dump(response)
//            }
            .responseDecodable(of: Similar.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    
                    self.similarInfo = value
                    self.contentsCollectionView.reloadData()
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callRequestForRecomMovie() {
 
        let url = APIURL.recomMovieURL(id: dataFromPreviousPage?.id ?? 0)
        print(url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey,
            "accept": APIResponseStyle.tmdbJson
        ]
        let param:Parameters = ["language": APILanguage.tmdbKorean]
        
        AF.request(url, method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Recom.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    
                    self.recomInfo = value
                    self.contentsCollectionView.reloadData()
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    @objc func backBarBtnTapped() {
        
        dismiss(animated: true)
    }
    
    @objc func overViewBtnTapped() {
        
        if overViewDetailLabel.numberOfLines == 2 {
            overViewDetailLabel.numberOfLines = 0
            overViewBtn.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
        } else {
            
            overViewDetailLabel.numberOfLines = 2
            overViewBtn.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        }
        
        view.layoutIfNeeded()
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("셀갯수: \(castInfo.cast.count)")
       return castInfo.cast.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castTableView.dequeueReusableCell(withIdentifier: MediaDetailCastTableViewCell.identifier, for: indexPath) as! MediaDetailCastTableViewCell
        
      cell.configUI(data: castInfo.cast[indexPath.row])
        
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as! ContentsCollectionViewCell
          cell.backgroundColor = .red
        if indexPath.section == 0 {
            cell.configUI(data: similarInfo.results[indexPath.row], indexPath: indexPath)
            
        } else {
            cell.configUI2(data: recomInfo.results[indexPath.row], indexPath: indexPath)
        }
        return cell
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
          return CGSize(width: collectionView.frame.width, height: 20)
      }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier, for: indexPath) as? CustomCollectionHeaderView else {
                    return CustomCollectionHeaderView()
                }
                header.configure()
                return header
            }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return similarInfo.results.count
        } else {
        return recomInfo.results.count}
    }
    }
