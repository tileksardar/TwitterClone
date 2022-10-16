//
//  ConversationsController.swift
//  TwitterClone
//
//  Created by Tilek on 12/9/22.
//

import UIKit


class ConversationsController: UIViewController{
    // MARK: - Properties
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
         configureUI()
    }
    // MARK: - Helpers

    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Messages"
}
}
