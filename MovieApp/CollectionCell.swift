//
//  CollectionCell.swift
//  MovieApp
//
//  Created by endava on 17.05.2024..
//

import Foundation
import UIKit
import PureLayout

class CollectionCell: UICollectionViewCell {
    
    var cellViewCollection: UIView!
    var image: UIImageView!
    var heartButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
        styleCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCell() {
        cellViewCollection = UIView()
        cellViewCollection.backgroundColor = .white
        cellViewCollection.layer.shadowColor = UIColor.black.cgColor
        cellViewCollection.layer.shadowRadius = 10
        cellViewCollection.layer.shadowOpacity = 0.4
        cellViewCollection.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellViewCollection.layer.cornerRadius = 10
        
        contentView.addSubview(cellViewCollection)
        
        image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        cellViewCollection.addSubview(image)
        
        heartButton = UIButton()
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.contentMode = .scaleAspectFit
        heartButton.tintColor = .white
        heartButton.backgroundColor = .gray
        heartButton.alpha = 0.7
        heartButton.layer.cornerRadius = 10
    
        cellViewCollection.addSubview(heartButton)
    }
    
    func styleCell() {
        cellViewCollection.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
        image.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        heartButton.autoPinEdge(.top, to: .top, of: cellViewCollection, withOffset: 20)
        heartButton.autoPinEdge(.leading, to: .leading, of: cellViewCollection, withOffset: 20)
        heartButton.autoSetDimensions(to: CGSize(width: 30, height: 30))
        
    }
}
