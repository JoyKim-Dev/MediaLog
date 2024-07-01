//
//  YoutubeWebViewController.swift
//  MediaLog
//
//  Created by Joy Kim on 7/1/24.
//

import UIKit

import SnapKit
import WebKit

final class YoutubeWebViewController: BaseViewController {
    
    private let webView = WKWebView()
    private var videoData = Video(id: 0, results: [])
    var receivedMovieURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarBtnTapped))
        navigationItem.leftBarButtonItem = backBarBtn
        
        requestWebView()
    }
    
    
    override func configHierarchy() {
        view.addSubview(webView)
    }
    
    override func configLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        configureView("TRAILER")
    }
    
    @objc func backBarBtnTapped() {
       dismiss(animated: true)
    }
    
    private func requestWebView() {
        guard let url = receivedMovieURL else {
            print("유효하지 않은 url")
            return
        }
        
        guard let validUrl = URL(string: url) else {return}
        
        let request = URLRequest(url: validUrl)
        webView.load(request)
    }

}
