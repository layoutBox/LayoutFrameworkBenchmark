// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit
import AsyncDisplayKit

/// A LinkedIn feed item that is implemented with Texture.
class FeedItemTextureView: ASCellNode {
    let topBarView = TopBarNode()
    let miniProfileView = MiniProfileNode()
    let miniContentView = MiniContentNode()
    let socialActionsView = SocialActionsNode()
    let commentView = CommentNode()

    init(data: FeedItemData) {
        topBarView.actionLabel.attributedText = data.actionText.makeAttributedString()
        miniProfileView.posterNameLabel.attributedText = data.posterName.makeAttributedString()
        miniProfileView.posterHeadlineLabel.attributedText = data.posterHeadline.makeAttributedString()
        miniProfileView.posterTimeLabel.attributedText = data.posterTimestamp.makeAttributedString()
        miniProfileView.posterCommentLabel.attributedText = data.posterComment.makeAttributedString()
        miniContentView.contentTitleLabel.attributedText = data.contentTitle.makeAttributedString()
        miniContentView.contentDomainLabel.attributedText = data.contentDomain.makeAttributedString()
        commentView.actorCommentLabel.attributedText = data.actorComment.makeAttributedString()
        super.init()
        [topBarView, miniProfileView, miniContentView, socialActionsView, commentView].forEach { addSubnode($0) }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0.0,
                                          justifyContent: .spaceBetween,
                                          alignItems: .stretch,
                                          children: [topBarView, miniProfileView, miniContentView, socialActionsView, commentView])
        return mainStack
    }
}

class CommentNode: ASDisplayNode {
    let actorImageView: ASImageNode = {
        let i = ASImageNode()
        i.image = UIImage(named: "50x50.png")
        return i
    }()

    let actorCommentLabel: ASTextNode = ASTextNode()

    override init() {
        super.init()
        [actorImageView, actorCommentLabel].forEach { addSubnode($0) }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        actorCommentLabel.style.flexGrow = 1.0
        let mainStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0.0,
                                          justifyContent: .spaceBetween,
                                          alignItems: .start,
                                          children: [actorImageView, actorCommentLabel])
        return mainStack
    }
}

class MiniContentNode: ASDisplayNode {
    let contentImageView: ASImageNode = {
        let i = ASImageNode()
        i.image = UIImage(named: "350x200.png")
        i.contentMode = .scaleAspectFit
        i.backgroundColor = UIColor.orange
        return i
    }()

    let contentTitleLabel: ASTextNode = ASTextNode()
    let contentDomainLabel: ASTextNode = ASTextNode()

    override init() {
        super.init()
        [contentImageView, contentTitleLabel, contentDomainLabel].forEach { addSubnode($0) }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0.0,
                                          justifyContent: .spaceBetween,
                                          alignItems: .stretch,
                                          children: [contentImageView, contentTitleLabel, contentDomainLabel])
        return mainStack
    }
}

class MiniProfileNode: ASDisplayNode {
    let posterImageView: ASImageNode = {
        let i = ASImageNode()
        i.image = UIImage(named: "50x50.png")
        i.backgroundColor = UIColor.orange
        i.contentMode = .center
        return i
    }()

    let posterNameLabel: ASTextNode = {
        let l = ASTextNode()
        l.backgroundColor = UIColor.yellow
        return l
    }()

    let posterHeadlineLabel: ASTextNode = {
        let l = ASTextNode()
        l.maximumNumberOfLines = 3
        l.backgroundColor = UIColor.yellow
        return l
    }()

    let posterTimeLabel: ASTextNode = {
        let l = ASTextNode()
        l.backgroundColor = UIColor.yellow
        return l
    }()

    let posterCommentLabel: ASTextNode = ASTextNode()

    override init() {
        super.init()
        [posterNameLabel, posterHeadlineLabel, posterTimeLabel, posterImageView, posterCommentLabel].forEach { addSubnode($0) }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textStack = ASStackLayoutSpec(direction: .vertical, spacing: 1.0, justifyContent: .spaceBetween, alignItems: .stretch, children: [posterNameLabel, posterHeadlineLabel, posterTimeLabel])
        textStack.style.flexGrow = 1.0

        let imageTextStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 2.0,
                                               justifyContent: .spaceBetween,
                                               alignItems: .start,
                                               children: [posterImageView,
                                                          textStack])

        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 3.0,
                                          justifyContent: .start,
                                          alignItems: .stretch,
                                          children: [imageTextStack,
                                                     posterCommentLabel])

        let insetStack = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 4.0),
                                           child: mainStack)

        return insetStack
    }
}

class SocialActionsNode: ASDisplayNode {
    let likeLabel: ASTextNode = {
        let l = ASTextNode()
        l.attributedText = "Like".makeAttributedString()
        l.backgroundColor = .green
        return l
    }()

    let commentLabel: ASTextNode = {
        let l = ASTextNode()
        l.attributedText = "Comment".makeAttributedString()
        l.backgroundColor = .green
        return l
    }()

    let shareLabel: ASTextNode = {
        let l = ASTextNode()
        l.attributedText = "Share".makeAttributedString()
        l.backgroundColor = .green
        return l
    }()

    override init() {
        super.init()
        [likeLabel, commentLabel, shareLabel].forEach { addSubnode($0) }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0.0,
                                          justifyContent: .spaceBetween,
                                          alignItems: .start,
                                          children: [likeLabel, commentLabel, shareLabel])
        return mainStack
    }
}

class TopBarNode: ASDisplayNode {
    let actionLabel: ASTextNode = ASTextNode()

    let optionsLabel: ASTextNode = {
        let l = ASTextNode()
        l.attributedText = "...".makeAttributedString()
        return l
    }()

    override init() {
        super.init()
        [actionLabel, optionsLabel].forEach { addSubnode($0) }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [actionLabel, optionsLabel])
        actionLabel.style.flexGrow = 1.0
        return mainStack
    }
}

private extension String {
    func makeAttributedString() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: 17.0)])
    }
}
