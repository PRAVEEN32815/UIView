//
//  ViewController.swift
//  UIViewProgramatically
//
//  Created by Arun Muthukumar on 09/03/21.
//  Copyright © 2021 Arun Muthukumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var liked = false
    var mainView : MainView { return self.view as! MainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.likeAction = { [weak self] in
            guard let strongself = self  else { return }
            strongself.liked = !strongself.liked
            
            if strongself.liked{
                UIView.animate(withDuration: 0.5, animations:{ strongself.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                    strongself.mainView.likeButton.setTitle("dislike", for: .normal)} )
            }else
            {
                UIView.animate(withDuration: 0.5, animations:{ strongself.mainView.contentView.backgroundColor = UIColor.clear
                    strongself.mainView.likeButton.setTitle("like", for: .normal)} )
            }
        }
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }

}

class MainView : UIView {
    
    var likeAction : (() -> Void)?
    var safeArea = UILayoutGuide()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        safeArea = self.layoutMarginsGuide
        setupViews()
        setupConstraints()
        addAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(contentView)
        self.addSubview(likeButton)
    }
    func addAction(){
        likeButton.addTarget(self, action: #selector(onLikeButton), for: .touchUpInside)
    }
    
    @objc func onLikeButton(){
        likeAction?()
    }
    
    func setupConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 20).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        likeButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }
    
    var contentView : UIView =
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let likeButton : UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("like", for: .normal)
        return button
    }()
}

