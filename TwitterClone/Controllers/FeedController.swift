//
//  FeedController.swift
//  TwitterClone
//
//  Created by Tilek on 12/9/22.
//

import UIKit
import SDWebImage

class FeedController: UIViewController{
    
    // MARK: - Properties
    
    var user: User?{
        didSet{
            configureLeftBarButtom()
        }
    }
    // MARK: - Lifecycle


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()    }
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        let imageView = UIImageView(image:  UIImage(named:"twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
    
    }
    
    func configureLeftBarButtom(){
        guard let user = user else {return}
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.layer.masksToBounds = true

        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
    }
}
