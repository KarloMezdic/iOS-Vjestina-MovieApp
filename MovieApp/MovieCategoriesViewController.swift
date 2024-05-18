//
//  MovieCategorysViewController.swift
//  MovieApp
//
//  Created by endava on 16.05.2024..
//

import Foundation
import PureLayout
import MovieAppData
import UIKit

class MovieCategoriesViewController : UIViewController{

    
    private var tableView : UITableView!
    private var collectionView : UICollectionView!
    private var movieUseCase : MovieUseCaseProtocol!
    private var whatsPopular : [MovieModel] = []
    private var freeToWatch : [MovieModel] = []
    private var trending : [MovieModel] = []
    
    override func loadView() {
        super.loadView()

        buildView()
        styleView()
        loadCategorys()
    }
    
    func buildView(){
        
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        

        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        tableView.addSubview(collectionView)
        
    }
    
    func styleView(){
        tableView.autoPinEdge(toSuperviewSafeArea: .top)
        tableView.autoPinEdge(toSuperviewSafeArea: .bottom)
        tableView.autoPinEdge(toSuperviewSafeArea: .leading)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing)
    }
    
    func loadCategorys(){
        movieUseCase = MovieUseCase()
        whatsPopular = movieUseCase.popularMovies
        trending = movieUseCase.trendingMovies
        freeToWatch = movieUseCase.freeToWatchMovies
        tableView.reloadData()
    }
}

extension MovieCategoriesViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
         
        switch indexPath.section{
            case 0:
                cell.sectionName.text = "What's Popular"
            
            case 1:
                cell.sectionName.text = "Free to Watch"
            case 2:
                cell.sectionName.text = "Trending"
            default:
                break
            }
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension MovieCategoriesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
            case 0:
                return whatsPopular.count
            case 1:
                return freeToWatch.count
            case 2:
                return trending.count
            default:
                return 0
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            
        var movieList: [MovieModel] = []
        
        switch collectionView.tag {
        case 0:
            movieList = whatsPopular
        case 1:
            movieList = freeToWatch
        case 2:
            movieList = trending
        default:
            break
        }
        
        let movie = movieList[indexPath.item]
        
        let movImage = UIImageView(frame: collectionCell.contentView.bounds)
        movImage.contentMode = .scaleAspectFill
        movImage.layer.cornerRadius = 10
        movImage.load(url: URL(string: movie.imageUrl)!)
        movImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionCell.addSubview(movImage)
        collectionCell.layer.cornerRadius = 10
        collectionCell.layer.masksToBounds = true
        
        collectionCell.addSubview(collectionCell.heartButton)
        
        return collectionCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width/3
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
    
    
}





