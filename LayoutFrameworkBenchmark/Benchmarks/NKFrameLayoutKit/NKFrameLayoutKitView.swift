//
//  NKFrameLayoutKitView.swift
//  LayoutFrameworkBenchmark
//
//  Created by Nam Kennic on 6/24/18.
//

import UIKit
import NKFrameLayoutKit

/// A LinkedIn feed item that is implemented with NKFrameLayoutKit code.
class NKFrameLayoutKitView: UIView, DataBinder {
    
    var mainFrameLayout: NKGridFrameLayout!
    
    let actionLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor.blue
        return l
    }()
    
    let optionsLabel: UILabel = {
        let l = UILabel()
        l.text = "..."
        return l
    }()
    
    let posterImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        i.backgroundColor = UIColor.orange
        i.contentMode = .scaleToFill
        return i
    }()
    
    let posterNameLabel: UILabel = UILabel()
    
    let posterHeadlineLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        return l
    }()
    
    let posterTimeLabel: UILabel = UILabel()
    let posterCommentLabel: UILabel = UILabel()
    
    let contentImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "350x200.png")
        i.contentMode = .scaleToFill
        return i
    }()
    
    let contentTitleLabel: UILabel = UILabel()
    let contentDomainLabel: UILabel = UILabel()
    
    let likeLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor(red: 0, green: 0.9, blue: 0, alpha: 1)
        l.text = "Like"
        return l
    }()
    
    let commentLabel: UILabel = {
        let l = UILabel()
        l.text = "Comment"
        l.backgroundColor = UIColor(red: 0, green: 1.0, blue: 0, alpha: 1)
        l.textAlignment = .center
        return l
    }()
    
    let shareLabel: UILabel = {
        let l = UILabel()
        l.text = "Share"
        l.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
        l.textAlignment = .right
        return l
    }()
    
    let actorImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        return i
    }()
    
    let actorCommentLabel: UILabel = UILabel()
    
    lazy var topBar: NKDoubleFrameLayout = {
        let v = NKDoubleFrameLayout(direction: .horizontal, andViews: [self.actionLabel, self.optionsLabel])!
        v.rightFrameLayout.contentHorizontalAlignment = .right
        return v
    }()
    
    lazy var posters: NKDoubleFrameLayout = {
        let labels = NKGridFrameLayout(direction: .vertical, andViews: [self.posterNameLabel, self.posterHeadlineLabel, self.posterTimeLabel])!
        let v = NKDoubleFrameLayout(direction: .horizontal, andViews: [self.posterImageView, labels])!
        v.leftFrameLayout.contentVerticalAlignment = .center
        v.spacing = 5
        v.edgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return v
    }()
    
    lazy var actions: NKGridFrameLayout = {
        let v = NKGridFrameLayout(direction: .horizontal)! // andViews: [self.likeLabel, self.commentLabel, self.shareLabel]
        v.add(withTargetView: self.likeLabel).contentHorizontalAlignment = .left
        v.add(withTargetView: self.commentLabel).contentHorizontalAlignment = .center
        v.add(withTargetView: self.shareLabel).contentHorizontalAlignment = .right
        v.layoutAlignment = .split
        return v
    }()
    
    lazy var comment: NKDoubleFrameLayout = {
        let v = NKDoubleFrameLayout(direction: .horizontal, andViews: [self.actorImageView, self.actorCommentLabel])!
        v.edgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        v.spacing = 5
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(actionLabel)
        addSubview(optionsLabel)
        addSubview(posterImageView)
        addSubview(posterNameLabel)
        addSubview(posterHeadlineLabel)
        addSubview(posterTimeLabel)
        addSubview(posterCommentLabel)
        addSubview(contentImageView)
        addSubview(contentTitleLabel)
        addSubview(contentDomainLabel)
        addSubview(likeLabel)
        addSubview(commentLabel)
        addSubview(shareLabel)
        addSubview(actorImageView)
        addSubview(actorCommentLabel)
        backgroundColor = UIColor.white
        
        mainFrameLayout = NKGridFrameLayout(direction: .vertical, andViews: [topBar, posters, posterCommentLabel, contentImageView, contentTitleLabel, contentDomainLabel, actions, comment])
        mainFrameLayout.edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        addSubview(mainFrameLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: FeedItemData) {
        actionLabel.text = data.actionText
        posterNameLabel.text = data.posterName
        posterHeadlineLabel.text = data.posterHeadline
        posterTimeLabel.text = data.posterTimestamp
        posterCommentLabel.text = data.posterComment
        contentTitleLabel.text = data.contentTitle
        contentDomainLabel.text = data.contentDomain
        actorCommentLabel.text = data.actorComment
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainFrameLayout.frame = self.bounds
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return mainFrameLayout.sizeThatFits(size)
    }
    
    override var intrinsicContentSize: CGSize {
        return mainFrameLayout.sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
}
