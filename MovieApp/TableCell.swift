//
//  TableCell.swift
//  MovieApp
//
//  Created by endava on 17.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData


class TableCell : UITableViewCell{
    
    var sectionName : UILabel!
    var collectionView : UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildTableViewCell()
        styleTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildTableViewCell(){
        
        sectionName = UILabel()
        sectionName.font = UIFont.boldSystemFont(ofSize: 25)
        
        contentView.addSubview(sectionName)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        contentView.addSubview(collectionView)
    }
    
    func styleTableViewCell(){
        
        sectionName.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        sectionName.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        sectionName.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: sectionName, withOffset: 10)
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoSetDimension(.height, toSize: 200)
        
    }
}
