//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Tilek on 8/11/22.
//

import UIKit

enum  UploadTweetConfiguration{
    case tweet
    case reply(Tweet)
}


struct UploadTweetViewModel {
    let actionaButtonTitle: String
    let placeHolderText: String
    var shouldShowReplyLabel: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration){
        switch config {
        case .tweet:
            actionaButtonTitle = "Tweet"
            placeHolderText = "What's happening"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionaButtonTitle = "Reply"
            placeHolderText = "Tweet your reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
