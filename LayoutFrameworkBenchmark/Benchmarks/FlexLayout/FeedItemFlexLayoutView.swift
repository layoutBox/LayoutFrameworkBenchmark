// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit
import FlexLayout

/// A LinkedIn feed item that is implemented with FlexLayout code.
class FeedItemFlexLayoutView: UIView, DataBinder {

    let contentView = UIView()

    let actionLabel: UILabel = {
        let l = UILabel()
        l.font = UILabel().font ?? UIFont.systemFont(ofSize: 17)
        return l
    }()

    let optionsLabel: UILabel = {
        let l = UILabel()
        l.font = UILabel().font ?? UIFont.systemFont(ofSize: 17)
        l.text = "..."
        return l
    }()

    let posterImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
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
        backgroundColor = .white

        flex.addItem(contentView).padding(8).define { (flex) in
            flex.addItem().direction(.row).justifyContent(.spaceBetween).define { (flex) in
                flex.addItem(actionLabel)
                flex.addItem(optionsLabel)
            }
            
            flex.addItem().direction(.row).alignItems(.center).define({ (flex) in
                flex.addItem(posterImageView).width(50).height(50).marginRight(8)

                flex.addItem().grow(1).define({ (flex) in
                    flex.addItem(posterNameLabel)
                    flex.addItem(posterHeadlineLabel)
                    flex.addItem(posterTimeLabel)
                })
            })

            flex.addItem(posterCommentLabel)

            flex.addItem(contentImageView).aspectRatio(350 / 200)
            flex.addItem(contentTitleLabel)
            flex.addItem(contentDomainLabel)

            flex.addItem().direction(.row).justifyContent(.spaceBetween).marginTop(4).define({ (flex) in
                flex.addItem(likeLabel)
                flex.addItem(commentLabel)
                flex.addItem(shareLabel)
            })

            flex.addItem().direction(.row).marginTop(2).define({ (flex) in
                flex.addItem(actorImageView).width(50).height(50).marginRight(8)
                flex.addItem(actorCommentLabel).grow(1)
            })
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(_ data: FeedItemData) {
        actionLabel.text = data.actionText
        actionLabel.flex.markDirty()

        posterNameLabel.text = data.posterName
        posterNameLabel.flex.markDirty()
        
        posterHeadlineLabel.text = data.posterHeadline
        posterHeadlineLabel.flex.markDirty()
        
        posterTimeLabel.text = data.posterTimestamp
        posterTimeLabel.flex.markDirty()
        
        posterCommentLabel.text = data.posterComment
        posterCommentLabel.flex.markDirty()
        
        contentTitleLabel.text = data.contentTitle
        contentTitleLabel.flex.markDirty()
        
        contentDomainLabel.text = data.contentDomain
        contentDomainLabel.flex.markDirty()
        
        actorCommentLabel.text = data.actorComment
        actorCommentLabel.flex.markDirty()
        
        
        // TODO: Redeo benchark!!!
        
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layout(size: bounds.size)
    }

    fileprivate func layout(size: CGSize) {
        flex.size(size).layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout(size: CGSize(width: size.width != .greatestFiniteMagnitude ? size.width : 10000,
                                   height: size.height != .greatestFiniteMagnitude ? size.height : 10000))
        return CGSize(width: size.width, height: contentView.frame.height + 4)
    }
    
    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude))
    }
}
