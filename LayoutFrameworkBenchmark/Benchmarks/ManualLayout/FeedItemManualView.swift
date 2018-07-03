// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

/// A LinkedIn feed item that is implemented with manual layout code.
class FeedItemManualView: UIView, DataBinder {
    let hMargin: CGFloat = 8

    let actionLabel: UILabel = {
        let l = UILabel()
        return l
    }()

    let optionsLabel: UILabel = {
        let l = UILabel()
        l.text = "..."
        l.sizeToFit()
        return l
    }()

    let posterImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        i.backgroundColor = UIColor.orange
        i.contentMode = .scaleToFill
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
        return l
    }()

    let posterTimeLabel: UILabel = {
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
        return l
    }()

    let commentLabel: UILabel = {
        let l = UILabel()
        l.text = "Comment"
        l.backgroundColor = .green
        l.textAlignment = .center
        return l
    }()

    let shareLabel: UILabel = {
        let l = UILabel()
        l.text = "Share"
        l.backgroundColor = .green
        l.textAlignment = .right
        return l
    }()

    let actorImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
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

        posterNameLabel.text = data.posterName
        posterNameLabel.sizeToFit()

        posterHeadlineLabel.text = data.posterHeadline
        posterHeadlineLabel.sizeToFit()

        posterTimeLabel.text = data.posterTimestamp
        posterTimeLabel.sizeToFit()

        posterCommentLabel.text = data.posterComment
        contentTitleLabel.text = data.contentTitle
        contentDomainLabel.text = data.contentDomain
        actorCommentLabel.text = data.actorComment
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let vMargin: CGFloat = 4
        let spacing: CGFloat = 1

        optionsLabel.frame = CGRect(x: bounds.width-optionsLabel.frame.width - hMargin, y: hMargin, width: optionsLabel.frame.width, height: optionsLabel.frame.height)
        actionLabel.frame = CGRect(x: hMargin, y: hMargin, width: bounds.width-optionsLabel.frame.width, height: 0)
        actionLabel.sizeToFit()

        posterImageView.frame = CGRect(x: hMargin, y: actionLabel.frame.bottom + 10, width: posterImageView.frame.width, height: 0)
        posterImageView.sizeToFit()

        let contentInsets = UIEdgeInsets(top: -10, left: 2, bottom: 2, right: 3)
        posterNameLabel.frame = CGRect(x: posterImageView.frame.right + contentInsets.left, y: posterImageView.frame.origin.y + contentInsets.top, width: posterNameLabel.frame.width, height: posterNameLabel.frame.height)

        posterHeadlineLabel.frame = CGRect(x: posterImageView.frame.right + contentInsets.left, y: posterNameLabel.frame.bottom + spacing, width: posterHeadlineLabel.frame.width, height: posterHeadlineLabel.frame.height)

        posterTimeLabel.frame = CGRect(x: posterImageView.frame.right + contentInsets.left, y: posterHeadlineLabel.frame.bottom + spacing, width: posterTimeLabel.frame.width, height: posterTimeLabel.frame.height)

        posterCommentLabel.frame = CGRect(x: hMargin, y: max(posterImageView.frame.bottom, posterTimeLabel.frame.bottom + contentInsets.bottom), width: frame.width, height: 0)
        posterCommentLabel.sizeToFit()

        contentImageView.frame = CGRect(x: hMargin, y: posterCommentLabel.frame.bottom, width: frame.width, height: 0)
        contentImageView.sizeToFit()

        contentTitleLabel.frame = CGRect(x: hMargin, y: contentImageView.frame.bottom, width: frame.width, height: 0)
        contentTitleLabel.sizeToFit()

        contentDomainLabel.frame = CGRect(x: hMargin, y: contentTitleLabel.frame.bottom, width: frame.width, height: 0)
        contentDomainLabel.sizeToFit()

        likeLabel.frame = CGRect(x: hMargin, y: contentDomainLabel.frame.bottom + vMargin, width: 0, height: 0)
        likeLabel.sizeToFit()

        commentLabel.sizeToFit()
        commentLabel.frame = CGRect(x: frame.width / 2 - commentLabel.frame.width / 2, y: contentDomainLabel.frame.bottom + vMargin, width: commentLabel.frame.width, height: commentLabel.frame.height)

        shareLabel.sizeToFit()
        shareLabel.frame = CGRect(x: frame.width - shareLabel.frame.width - hMargin, y: contentDomainLabel.frame.bottom + vMargin, width: shareLabel.frame.width, height: shareLabel.frame.height)

        actorImageView.frame = CGRect(x: hMargin, y: likeLabel.frame.bottom + vMargin, width: 0, height: 0)
        actorImageView.sizeToFit()

        actorCommentLabel.frame = CGRect(x: actorImageView.frame.right + vMargin,
                                         y: actorImageView.frame.minY + (actorImageView.frame.height - actorCommentLabel.frame.height) / 2,
                                         width: frame.width-actorImageView.frame.width,
                                         height: 0)
        actorCommentLabel.sizeToFit()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layoutSubviews()
        return CGSize(width: size.width, height: max(actorImageView.frame.bottom, actorCommentLabel.frame.bottom) + hMargin)
    }

    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
}

extension CGRect {
    var bottom: CGFloat {
        return origin.y + size.height
    }
    
    var right: CGFloat {
        return origin.x + size.width
    }
}
