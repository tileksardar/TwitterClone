//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Tilek on 12/9/22.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        } 
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabNavBarsAppeareance()
        //logUserOut()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
        
        
    }
    // MARK: - API
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
            
        }
    }
    
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        print("DEBUG: USER IS NOT LOGGED IN.." )
        }
        else{
            print("DEBUG: USER IS LOGGED IN..")
            
            configureViewController()
            configureUI()
            fetchUser()

        }
    }
    
    func logUserOut(){
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
        
    }
    // MARK: - Selectors
   @objc func actionButtonTapped(){
       
       guard let user = user else {
           return
       }

       let controller = UploadTweetController(user: user, config: .tweet)
       let nav = UINavigationController(rootViewController: controller)
       nav.modalPresentationStyle = .fullScreen
       present(nav, animated: true, completion: nil)
       
       
       
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        
        
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 46, height: 46)
        actionButton.layer.cornerRadius = 46 / 2
        
        
        
    }
    func setupTabNavBarsAppeareance(){
        
        let apparence = UITabBarAppearance()
           apparence.configureWithOpaqueBackground()
                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = apparence
                }
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    
    func configureViewController(){
        
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewCOntroller: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewCOntroller: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewCOntroller: notifications)
        
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewCOntroller: conversations)
        
        viewControllers = [nav1,nav2,nav3,nav4]
    }
    func templateNavigationController(image: UIImage?, rootViewCOntroller: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewCOntroller)
        nav.tabBarItem.image = image
    //  nav.navigationBar.barTintColor = .white
        return nav
    }

    
}
