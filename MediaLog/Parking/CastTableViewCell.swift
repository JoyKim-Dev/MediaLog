////
////  CastTableViewCell.swift
////  MediaLog
////
////  Created by Joy Kim on 6/25/24.
////
//
//import UIKit
//
//class CastTableViewCell: UITableViewCell {
//    
//    let tableView = UITableView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    
//        
//        configHierarchy()
//        configLayout()
//        configUI()
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//extension CastTableViewCell {
//    
//func configHierarchy() {
//     
//    contentView.addSubview(tableView)
//        
//    }
//    
//    func configLayout() {
//        
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(contentView)
//        }
//    }
//    
//    func configUI() {
//        tableView.backgroundColor = .orange
//    }
//    
//}
