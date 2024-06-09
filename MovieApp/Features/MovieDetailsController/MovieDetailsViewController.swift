//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by endava on 08.04.2024..
//

import Foundation
import Foundation
import UIKit
import PureLayout
import MovieAppData


class MovieDetailsViewController : UIViewController {
    

    var score : UILabel!
    var movName : UILabel!
    var summ : UILabel!
    var relDate : UILabel!
    var overview : UILabel!
    var genre : UILabel!
    var dur : UILabel!
    var numEl : Int!
    var act1 : UILabel!
    var act2 : UILabel!
    var act3 : UILabel!
    var act4 : UILabel!
    var act5 : UILabel!
    var appearance : UINavigationBarAppearance!
    
    private var router: Router!
    private var id : Int!
    
    let bounds = UIScreen.main.bounds
    let apiCall = ApiCall()
    var details : ApiCall.MovieRespDetails!
    
    init(router:Router!, id: Int!){
        self.router = router
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDetails() {
        Task {
            await apiCall.getDetail(with: id)
            DispatchQueue.main.async {
                self.details = self.apiCall.detail
                self.buildView()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDetails()
    }
        
    func setupUI() {
        title = "Movie Details"
        view.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    
    func buildView(){
    
        guard let detail = details else{
            print("Details is nil")
            return
        }
        print(detail)
        let stackView = UIStackView()
        
        let view1 = UIView()
        stackView.addArrangedSubview(view1)
        view1.backgroundColor = .white
        view1.autoPinEdge(toSuperviewEdge: .top)
        
        
        let view2 = UIView()
        stackView.addArrangedSubview(view2)
        view2.backgroundColor = .white
        view2.autoPinEdge(.top, to: .bottom, of: view1)
        
        let view3 = UIView()
        stackView.addArrangedSubview(view3)
        view3.backgroundColor = .white
        view3.autoPinEdge(.top, to: .bottom, of: view2)
        view3.alpha = 0
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewSafeArea()
        

        guard let name = detail.name else {
            return
        }
    
        guard let summaryvar = detail.summary else{
            return
        }
        guard let imageUrl = detail.imageUrl else{
            return
        }
        if detail.relDate == nil{
            let releaseDate=""
        }
        else{
            let releaseDate = detail.relDate
        }
        guard let year = detail.year else{
            return
        }
        guard let duration = detail.duration else{
            return
        }
        guard let rating = detail.rating else{
            return
        }
        guard let crewMembers = detail.crewMembers else{
            return
        }
        let movieImg = UIImageView()
        movieImg.contentMode = .scaleAspectFill
        movieImg.clipsToBounds = true
        movieImg.load(url: URL(string: imageUrl)!)
        view1.addSubview(movieImg)
        movieImg.autoPinEdgesToSuperviewEdges()
    
        
        movName=UILabel()
        view1.addSubview(movName)
        movName.text = String(name) + " (" + String(year) + ")"
        movName.font = UIFont.systemFont(ofSize: 21)
        movName.textColor = .white
        movName.autoPinEdge(.bottom, to: .bottom, of: view1, withOffset: -60)
        movName.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        movName.autoSetDimensions(to: .init(width: bounds.width, height: 30))
        animateText(label: movName)
        
        score = UILabel()
        view1.addSubview(score)
        score.text = String(rating) + " User Score"
        score.textColor = .white
        score.font = UIFont.systemFont(ofSize: 21)
        score.autoPinEdge(.bottom, to: .top, of: movName, withOffset: -15)
        //score.autoAlignAxis(.horizontal, toSameAxisOf: view1, withOffset: -15)
        score.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        score.autoSetDimensions(to: .init(width: bounds.width, height: 30))
        animateText(label: score)
        
        relDate=UILabel()
        view1.addSubview(relDate)
        //relDate.text = String(releaseDate)
        relDate.font = UIFont.systemFont(ofSize: 15)
        relDate.textColor = .white
        relDate.autoPinEdge(.bottom, to: .bottom, of: view1, withOffset: -35)
        relDate.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        relDate.autoSetDimensions(to: .init(width: bounds.width, height: 17))
        animateText(label: relDate)
        
        genre = UILabel()
        view1.addSubview(genre)
        
        var str : String!
        str = "Drama"
        str+=" / " + String(duration)+" min"
        genre.text = str
        genre.font = UIFont.boldSystemFont(ofSize: 15)
        genre.textColor = .white
        genre.autoPinEdge(.bottom, to: .bottom, of: view1, withOffset: -10)
        genre.autoSetDimensions(to: .init(width: bounds.width/2, height: 17))
        genre.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        animateText(label: genre)
        
                
        overview = UILabel()
        view2.addSubview(overview)
        overview.textColor = .black
        overview.font = UIFont.systemFont(ofSize: 30)
        overview.font = UIFont.boldSystemFont(ofSize: 30)
        overview.text = "Overview"
        overview.autoPinEdge(.top, to: .top, of: view2, withOffset: 10)
        overview.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overview.autoSetDimensions(to: .init(width: bounds.width, height: 50))

        summ=UILabel()
        view2.addSubview(summ)
        summ.text = summaryvar
        summ.textColor = .black
        summ.font = UIFont.systemFont(ofSize: 18)
        summ.backgroundColor = .white
        summ.lineBreakMode = .byWordWrapping
        summ.numberOfLines = 0
        summ.autoPinEdge(.top, to: .bottom, of: overview, withOffset: 5)
        summ.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        summ.autoSetDimensions(to: .init(width: bounds.width-50, height: 200))
        animateTextLast(label: summ, completion: {
            self.animateView(view: view3)
        })
        
        
        act1 = UILabel()
        view3.addSubview(act1)
        act1.lineBreakMode = .byWordWrapping
        act1.numberOfLines = 0
        act1.textColor = .black
        act1.text = String(crewMembers[0].name) + "     " + String(crewMembers[0].role)
        act1.font = UIFont.systemFont(ofSize: 14)
        act1.autoPinEdge(.top , to: .top , of: view3, withOffset: 10)
        act1.autoSetDimensions(to: .init(width: (bounds.width-60)/3, height: 40))
        act1.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        
        act2 = UILabel()
        view3.addSubview(act2)
        act2.lineBreakMode = .byWordWrapping
        act2.numberOfLines = 0
        act2.textColor = .black
        act2.text = String(crewMembers[1].name) + "     " + String(crewMembers[1].role)
        act2.font = UIFont.systemFont(ofSize: 14)
        act2.autoPinEdge(.leading , to: .trailing , of: act1, withOffset: 5)
        act2.autoPinEdge(.top , to: .top , of: view3, withOffset: 10)
        act2.autoSetDimensions(to: .init(width: (bounds.width-60)/3, height: 40))
        
        act3 = UILabel()
        view3.addSubview(act3)
        act3.lineBreakMode = .byWordWrapping
        act3.numberOfLines = 0
        act3.textColor = .black
        act3.text = String(crewMembers[2].name) + "     " + String(crewMembers[2].role)
        act3.font = UIFont.systemFont(ofSize: 14)
        act3.autoPinEdge(.leading , to: .trailing , of: act2, withOffset: 5)
        act3.autoPinEdge(.top , to: .top , of: view3, withOffset: 10)
        act3.autoSetDimensions(to: .init(width: (bounds.width-60)/3, height: 40))
            
        act4 = UILabel()
        view3.addSubview(act4)
        act4.lineBreakMode = .byWordWrapping
        act4.numberOfLines = 0
        act4.textColor = .black
        act4.text = String(crewMembers[3].name) + "      " + String(crewMembers[3].role)
        act4.font = UIFont.systemFont(ofSize: 14)
        act4.autoPinEdge(.top , to: .bottom , of: act1, withOffset: 40)
        act4.autoSetDimensions(to: .init(width: (bounds.width-60)/3, height: 40))
        act4.autoPinEdge(toSuperviewSafeArea: .leading , withInset: 5)
        
        act5 = UILabel()
        view3.addSubview(act5)
        act5.lineBreakMode = .byWordWrapping
        act5.numberOfLines = 0
        act5.textColor = .black
        act5.text = String(crewMembers[4].name) + "     " + String(crewMembers[4].role)
        act5.font = UIFont.systemFont(ofSize: 14)
        act5.autoPinEdge(.leading , to: .trailing , of: act4, withOffset: 5)
        act5.autoPinEdge(.top, to: .bottom, of: act2, withOffset: 40)
        act5.autoSetDimensions(to: .init(width: (bounds.width-60)/3, height: 40))
            
    }
    
    private func animateView(view:UIView!){
        view.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            view.alpha = 1
        }, completion: nil)
        
    }
    
    private func animateText(label : UILabel!){
        label.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            label.transform = .identity
        }, completion: nil)
    }
    
    private func animateTextLast(label:UILabel!, completion: @escaping ()-> Void){
        label.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            label.transform = .identity
        }, completion: { _ in
                completion()})
    }

}
