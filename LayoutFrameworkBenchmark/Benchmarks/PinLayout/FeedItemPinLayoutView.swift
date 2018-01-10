// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit
import PinLayout

/// A LinkedIn feed item that is implemented with PinLayout code.
class FeedItemPinLayoutView: UIView, DataBinder {

    let actionLabel: UILabel = {
        let l = UILabel()
        l.font = UILabel().font ?? UIFont.systemFont(ofSize: 17)
        return l
    }()

    let optionsLabel: UILabel = {
        let l = UILabel()
        l.font = UILabel().font ?? UIFont.systemFont(ofSize: 17)
        l.text = "..."
        l.sizeToFit()
        return l
    }()

    let posterImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        i.backgroundColor = UIColor.orange
        i.contentMode = .center
        i.sizeToFit()
        return i
    }()

    let posterNameLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor.yellow
        return l
    }()

    let posterHeadlineLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor.yellow
        l.numberOfLines = 3
        return l
    }()

    let posterTimeLabel: UILabel  = {
        let l = UILabel()
        l.backgroundColor = UIColor.yellow
        return l
    }()
    
    let posterCommentLabel: UILabel = UILabel()

    let contentImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "350x200.png")
        i.contentMode = .scaleToFill
        i.sizeToFit()
        return i
    }()

    let contentTitleLabel: UILabel = UILabel()
    let contentDomainLabel: UILabel = UILabel()

    let likeLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = .green
        l.text = "Like"
        l.sizeToFit()
        return l
    }()

    let commentLabel: UILabel = {
        let l = UILabel()
        l.text = "Comment"
        l.backgroundColor = .green
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()

    let shareLabel: UILabel = {
        let l = UILabel()
        l.text = "Share"
        l.backgroundColor = .green
        l.textAlignment = .right
        l.sizeToFit()
        return l
    }()

    let actorImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        i.sizeToFit()
        return i
    }()

    let actorCommentLabel: UILabel = UILabel()

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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(_ data: FeedItemData) {
        actionLabel.text = data.actionText
        actionLabel.sizeToFit()
        
        posterNameLabel.text = data.posterName
        posterHeadlineLabel.text = data.posterHeadline
        posterTimeLabel.text = data.posterTimestamp
        
        posterCommentLabel.text = data.posterComment
        contentTitleLabel.text = data.contentTitle
        contentDomainLabel.text = data.contentDomain
        actorCommentLabel.text = data.actorComment
        actorCommentLabel.sizeToFit()
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let hMargin: CGFloat = 8
        let vMargin: CGFloat = 2
        
        optionsLabel.pin.topRight().margin(hMargin)
        actionLabel.pin.topLeft().margin(hMargin)
        
        posterImageView.pin.below(of: actionLabel, aligned: .left).marginTop(10)
        
        posterNameLabel.pin.right(of: posterImageView, aligned: .top).margin(-6, 6).right(hMargin).sizeToFit(.width)
        posterHeadlineLabel.pin.below(of: posterNameLabel, aligned: .left).right(hMargin).marginTop(1).sizeToFit(.width)
        posterTimeLabel.pin.below(of: posterHeadlineLabel, aligned: .left).right(hMargin).marginTop(1).sizeToFit(.width)
        
        posterCommentLabel.pin.below(of: posterTimeLabel).left(hMargin).right(hMargin).marginTop(vMargin).sizeToFit(.width)
        
        contentImageView.pin.below(of: posterCommentLabel, aligned: .left).right().marginRight(hMargin)
        contentTitleLabel.pin.below(of: contentImageView).left().right().marginHorizontal(hMargin).sizeToFit(.width)
        contentDomainLabel.pin.below(of: contentTitleLabel, aligned: .left).right().marginRight(hMargin).sizeToFit(.width)
        
        likeLabel.pin.below(of: contentDomainLabel, aligned: .left).marginTop(vMargin)
        commentLabel.pin.top(to: likeLabel.edge.top).hCenter(50%)
        shareLabel.pin.top(to: likeLabel.edge.top).right().marginRight(hMargin)
        
        actorImageView.pin.below(of: likeLabel, aligned: .left).marginTop(vMargin)
        actorCommentLabel.pin.right(of: actorImageView, aligned: .center).marginLeft(4)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layoutSubviews()
        return CGSize(width: size.width, height: max(actorImageView.frame.maxY, actorCommentLabel.frame.maxY) + 4)
    }
    
    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude))
    }
}
