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

    private let apiCall = ApiCall()
    private var tableView : UITableView!
    private var collectionView : UICollectionView!
    private var whatsPopular : [ApiCall.MovieResp] = []
    private var freeToWatch : [ApiCall.MovieResp] = []
    private var trending : [ApiCall.MovieResp] = []
    private let router : Router!
    
    init(router : Router!){
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        title = "Movie List"
        view.backgroundColor = .white
        buildView()
        styleView()
        loadCategories()
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
    
    func loadCategories() {
        Task {
            do {
                await apiCall.getAll()
                self.whatsPopular = apiCall.popular
                self.trending = apiCall.trending
                self.freeToWatch = apiCall.freeToWatch
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
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
            
        var movieList: [ApiCall.MovieResp] = []
        
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
        movImage.load(url: URL(string: movie.imageUrl ?? "")!)
        movImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        collectionCell.image.isUserInteractionEnabled = true
        collectionCell.image.addGestureRecognizer(tapGestureRecognizer)
        collectionCell.image.tag = movie.id ?? 0
        
        collectionCell.addSubview(movImage)
        collectionCell.layer.cornerRadius = 10
        collectionCell.layer.masksToBounds = true
        
        collectionCell.addSubview(collectionCell.heartButton)
        
        return collectionCell
        
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer){
        guard let imageView = sender.view as? UIImageView else { return }
        let movId = imageView.tag
        router.showMovieDetails(id: movId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width/3
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
    
    
}





