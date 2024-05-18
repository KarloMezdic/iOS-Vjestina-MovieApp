//
//  LoginViewController.swift
//  MovieApp
//
//  Created by endava on 08.04.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class LoginViewController : UIViewController{
    
    var username: UITextField!
    var password: UITextField!
    var login: UIButton!
    var remember: UILabel!
    var checkbox: UISwitch!
    let background = UIImage(named: "background.png")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        username=UITextField()
        username.placeholder = "Username"
        username.borderStyle = .roundedRect
        view.addSubview(username)
        
        password=UITextField()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        password.backgroundColor = .white
        view.addSubview(password)
        
        login=UIButton(type: .system)
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .gray
        view.addSubview(login)
        
        remember=UILabel()
        remember.text = "Remember me?"
        remember.textColor = .white
        remember.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.addSubview(remember)
        
        checkbox=UISwitch()
        checkbox.onTintColor = .green
        checkbox.thumbTintColor = .white
        checkbox.backgroundColor = nil
        
        view.addSubview(checkbox)
     
        buildViews()
    }
    
    private func buildViews(){
        username.autoPinEdge(toSuperviewSafeArea: .top, withInset: 200)
        username.autoAlignAxis(toSuperviewAxis: .vertical)
        username.autoSetDimensions(to: .init(width: 300, height: 40))
        
        password.autoPinEdge(.top, to: .bottom, of: username, withOffset: 20)
        password.autoAlignAxis(toSuperviewAxis: .vertical)
        password.autoSetDimensions(to: .init(width: 300, height: 40))
        
        login.autoPinEdge(.top, to: .bottom, of: password, withOffset: 15)
        login.autoAlignAxis(toSuperviewAxis: .vertical)
        login.autoSetDimensions(to: .init(width: 60, height: 30))
        
        
        remember.autoPinEdge(.top, to: .bottom, of: login, withOffset: 20)
        remember.autoPinEdge(.leading, to: .leading, of: password, withOffset: 20)
        remember.autoSetDimensions(to: .init(width: 150, height: 40))
        
        checkbox.autoPinEdge(.leading, to: .trailing, of: remember, withOffset: 20)
        checkbox.autoPinEdge(.top, to: .bottom, of: login, withOffset: 20)
        checkbox.autoSetDimensions(to: .init(width: 50, height: 50))
        
        
    }
    @objc private func loginTapped(){
        let AppView=MovieDetailsViewController()
        present(AppView,animated: true, completion: nil)
    }
    
}
