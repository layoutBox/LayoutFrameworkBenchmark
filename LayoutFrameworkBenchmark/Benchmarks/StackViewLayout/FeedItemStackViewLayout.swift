// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit
import StackViewLayout

/// A LinkedIn feed item that is implemented with StackViewLayout code.
class FeedItemStackViewLayoutView: UIView, DataBinder {

    let stackView = StackView()

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

        stackView.padding(all: 8).define { (stackView) in
            stackView.addStackView().direction(.row).justifyContent(.spaceBetween).define { (stackView) in
                stackView.addItem(actionLabel)
                stackView.addItem(optionsLabel)
            }

            stackView.addStackView().direction(.row).alignItems(.center).define({ (stackView) in
                stackView.addItem(posterImageView).width(50).height(50).marginRight(8)

                stackView.addStackView().define({ (stackView) in
                    stackView.addItem(posterNameLabel)
                    stackView.addItem(posterHeadlineLabel)
                    stackView.addItem(posterTimeLabel)
                }).item.grow(1).shrink(1)
            })

            stackView.addItem(posterCommentLabel)
            stackView.addItem(contentImageView).aspectRatio(350 / 200)
            stackView.addItem(contentTitleLabel)
            stackView.addItem(contentDomainLabel)

            stackView.addStackView().direction(.row).justifyContent(.spaceBetween).define({ (stackView) in
                stackView.addItem(likeLabel)
                stackView.addItem(commentLabel)
                stackView.addItem(shareLabel)
            }).item.marginTop(4)

            stackView.addStackView().direction(.row).define({ (stackView) in
                stackView.addItem(actorImageView).width(50).height(50).marginRight(8)
                stackView.addItem(actorCommentLabel).grow(1)
            }).item.marginTop(2)
        }

        addSubview(stackView)
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

        stackView.markDirty()
        
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layout(size: bounds.size)
    }

    fileprivate func layout(size: CGSize) {
        stackView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return stackView.sizeThatFits(size)
    }

    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude))
    }
}
