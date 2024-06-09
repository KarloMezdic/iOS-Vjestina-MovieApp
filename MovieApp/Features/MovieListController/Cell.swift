//
//  Cell.swift
//  MovieApp
//
//  Created by endava on 16.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData


class Cell : UICollectionViewCell{

    
    var cellView : UIView!
    var name : UILabel!
    var summary : UILabel!
    var img : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildCellView()
        styleCellLayout()
        
    }
    
    func styleCellLayout(){
        
        cellView.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        cellView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        cellView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        cellView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        
        img.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        img.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        img.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        img.autoMatch(.width, to: .width, of: cellView, withMultiplier: 0.3)
        
        name.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        name.autoPinEdge(.leading, to: .trailing, of: img, withOffset: 20)
        name.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        summary.autoPinEdge(.leading, to: .trailing, of: img, withOffset: 20)
        summary.autoPinEdge(.top, to: .bottom, of: name, withOffset: 10)
        summary.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
    }
    
    func buildCellView(){
        
        cellView=UIView()
        cellView.backgroundColor = .white
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.cornerRadius = 15
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowRadius = 8
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(cellView)
        
        img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        
        cellView.addSubview(img)
        
        name = UILabel()
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        name.font = UIFont.boldSystemFont(ofSize: 17)
        cellView.addSubview(name)
        
        summary = UILabel()
        summary.numberOfLines = 0
        summary.font = UIFont.systemFont(ofSize: 14)
        summary.lineBreakMode = .byWordWrapping
        cellView.addSubview(summary)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Err")
    }
}

