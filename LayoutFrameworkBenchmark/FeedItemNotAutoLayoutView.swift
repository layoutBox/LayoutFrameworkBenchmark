// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import Foundation
import NotAutoLayout

/// A LinkedIn feed item that is implemented with NotAutoLayout code.
class FeedItemNotAutoLayoutView: UIView, DataBinder {
    
    private typealias Float = NotAutoLayout.Float
    
    private let actionTitleView = ActionTitleView()
    var actionLabel: UILabel {
        return actionTitleView.actionLabel
    }
    var optionsLabel: UILabel {
        return actionTitleView.optionsLabel
    }
    
    private let posterView = PosterView()
    var posterImageView: UIImageView {
        return posterView.posterImageView
    }
    var posterNameLabel: UILabel {
        return posterView.posterNameLabel
    }
    var posterHeadlineLabel: UILabel {
        return posterView.posterHeadlineLabel
    }
    var posterTimeLabel: UILabel {
        return posterView.posterTimeLabel
    }
    var posterCommentLabel: UILabel {
        return posterView.posterCommentLabel
    }
    
    private let contentView = ContentView()
    var contentImageView: UIImageView {
        return contentView.contentImageView
    }
    var contentTitleLabel: UILabel {
        return contentView.contentTitleLabel
    }
    var contentDomainLabel: UILabel {
        return contentView.contentDomainLabel
    }
    var likeLabel: UILabel {
        return contentView.likeLabel
    }
    var commentLabel: UILabel {
        return contentView.commentLabel
    }
    var shareLabel: UILabel {
        return contentView.shareLabel
    }
    
    private let actorView = ActorView()
    var actorImageView: UIImageView {
        return actorView.actorImageView
    }
    var actorCommentLabel: UILabel {
        return actorView.actorCommentLabel
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(actionTitleView)
        addSubview(posterView)
        addSubview(contentView)
        addSubview(actorView)
        backgroundColor = UIColor.white
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
        
        nal.layout(actionTitleView, by: { $0
            .setTopCenter(by: { $0.topCenter })
            .setWidth(by: { $0.layoutMarginsGuide.width })
            .fitHeight()
        })
        
        nal.layout(posterView, by: { $0
            .pinTopCenter(to: actionTitleView, with: { $0.bottomCenter + .init(x: 0, y: 1) })
            .setWidth(by: { $0.layoutMarginsGuide.width })
            .fitHeight()
        })
        
        nal.layout(contentView, by: { $0
            .pinTopCenter(to: posterView, with: { $0.bottomCenter + .init(x: 0, y: 1) })
            .setWidth(by: { $0.layoutMarginsGuide.width })
            .fitHeight()
        })
        
        nal.layout(actorView, by: { $0
            .pinTopCenter(to: contentView, with: { $0.bottomCenter + .init(x: 0, y: 1)  })
            .setWidth(by: { $0.layoutMarginsGuide.width })
            .fitHeight()
        })
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let fittingSize = CGSize(width: size.width, height: .greatestFiniteMagnitude)
        let actionHeight = actionTitleView.sizeThatFits(fittingSize).height
        let posterHeight = posterView.sizeThatFits(fittingSize).height
        let contentHeight = contentView.sizeThatFits(fittingSize).height
        let actorHeight = actorView.sizeThatFits(fittingSize).height
        let totalHeight = actionHeight + posterHeight + contentHeight + actorHeight + 3
        return .init(width: size.width, height: totalHeight)
    }
    
    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
    
}

private class ActionTitleView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(actionLabel)
        addSubview(optionsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nal.layout(optionsLabel, by: { $0
            .setTopRight(by: { $0.topRight })
            .fitSize()
        })
        
        nal.layout(actionLabel, by: { $0
            .setTopLeft(by: { $0.topLeft })
            .fitSize()
        })
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let optionsSize = optionsLabel.sizeThatFits(size)
        let actionWidth = size.width - optionsSize.width
        let actionHeight = actionLabel.sizeThatFits(.init(width: actionWidth, height: size.height)).height
        return .init(width: size.width, height: max(optionsSize.height, actionHeight))
    }
    
}

private class PosterView: UIView {
    
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
        l.numberOfLines = 3
        return l
    }()
    
    let posterTimeLabel: UILabel  = {
        let l = UILabel()
        l.backgroundColor = UIColor.yellow
        return l
    }()
    
    let posterCommentLabel: UILabel = UILabel()
    
    private let imageSize = Size(width: 50, height: 50)
    private let imageLabelMargin = NotAutoLayout.Float(8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        addSubview(posterNameLabel)
        addSubview(posterHeadlineLabel)
        addSubview(posterTimeLabel)
        addSubview(posterCommentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelsMaxSize = Size(width: Float(bounds.width) - imageSize.width, height: .greatestFiniteMagnitude)
        
        nal.layout(posterNameLabel, by: { $0
            .setLeft(by: { $0.left + self.imageSize.width + self.imageLabelMargin })
            .setTop(by: { $0.top })
            .fitSize(by: labelsMaxSize)
        })
        
        nal.layout(posterHeadlineLabel, by: { $0
            .setLeft(by: { $0.left + self.imageSize.width + self.imageLabelMargin })
            .pinTop(to: posterNameLabel, with: { $0.bottom + 1 })
            .fitSize(by: labelsMaxSize)
        })
        
        nal.layout(posterTimeLabel, by: { $0
            .setLeft(by: { $0.left + self.imageSize.width + self.imageLabelMargin })
            .pinTop(to: posterHeadlineLabel, with: { $0.bottom + 1 })
            .fitSize(by: labelsMaxSize)
        })
        
        nal.layout(posterImageView, by: { $0
            .setLeft(by: { $0.left })
            .setMiddle(by: { _ in Float(self.posterTimeLabel.frame.maxY - self.posterNameLabel.frame.minY) / 2 })
            .setSize(to: imageSize)
        })
        
        nal.layout(posterCommentLabel, by: { $0
            .setBottomCenter(by: { $0.bottomCenter })
            .setWidth(by: { $0.width })
            .fitHeight()
        })
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelsMaxSize = CGSize(width: size.width - imageSize.width.cgValue - imageLabelMargin.cgValue, height: .greatestFiniteMagnitude)
        let nameHeight = posterNameLabel.sizeThatFits(labelsMaxSize).height
        let headlineHeight = posterHeadlineLabel.sizeThatFits(labelsMaxSize).height
        let timeHeight = posterTimeLabel.sizeThatFits(labelsMaxSize).height
        let rightLabelsHeight = nameHeight + headlineHeight + timeHeight + 2
        
        let commentMaxSize = CGSize(width: size.width, height: .greatestFiniteMagnitude)
        let commentHeight = posterCommentLabel.sizeThatFits(commentMaxSize).height
        
        return .init(width: size.width, height: rightLabelsHeight + commentHeight + 1)
        
    }
    
}

private class ContentView: UIView {
    
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
    
    private let imageAspectRatio: NotAutoLayout.Float = 350 / 200
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentImageView)
        addSubview(contentTitleLabel)
        addSubview(contentDomainLabel)
        addSubview(likeLabel)
        addSubview(commentLabel)
        addSubview(shareLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nal.layout(contentImageView, by: { $0
            .setTopCenter(by: { $0.topCenter })
            .aspectFit(ratio: imageAspectRatio)
        })
        
        nal.layout(contentTitleLabel, by: { $0
            .pinTopLeft(to: contentImageView, with: { $0.bottomLeft + .init(x: 0, y: 1) })
            .fitSize()
        })
        
        nal.layout(contentDomainLabel, by: { $0
            .pinTopLeft(to: contentTitleLabel, with: { $0.bottomLeft + .init(x: 0, y: 1) })
            .fitSize()
        })
        
        nal.layout(likeLabel, by: { $0
            .setBottomLeft(by: { $0.bottomLeft })
            .fitSize()
        })
        
        nal.layout(commentLabel, by: { $0
            .setBottomCenter(by: { $0.bottomCenter })
            .fitSize()
        })
        
        nal.layout(shareLabel, by: { $0
            .setBottomRight(by: { $0.bottomRight })
            .fitSize()
        })
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let imageHeight = size.width / imageAspectRatio.cgValue
        
        let labelMaxSize = CGSize(width: size.width, height: .greatestFiniteMagnitude)
        let titleHeight = contentTitleLabel.sizeThatFits(labelMaxSize).height
        let domainHeight = contentTitleLabel.sizeThatFits(labelMaxSize).height
        
        let likeHeight = likeLabel.sizeThatFits(labelMaxSize).height
        
        let totalHeight = imageHeight + titleHeight + domainHeight + likeHeight + 3
        
        return .init(width: size.width, height: totalHeight)
    }
    
}

private class ActorView: UIView {
    
    let actorImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        return i
    }()
    
    let actorCommentLabel: UILabel = UILabel()
    
    private let imageSize = Size(width: 50, height: 50)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(actorImageView)
        addSubview(actorCommentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nal.layout(actorImageView, by: { $0
            .setMiddleLeft(by: { $0.middleLeft })
            .setSize(to: self.imageSize)
        })
        
        nal.layout(actorCommentLabel, by: { $0
            .pinMiddleLeft(to: actorImageView, with: { $0.middleRight + .init(x: 8, y: 0) })
            .setRight(by: { $0.right })
            .fitHeight()
        })
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelMaxSize = CGSize(width: size.width - imageSize.width.cgValue - 8, height: .greatestFiniteMagnitude)
        let labelHeight = actorCommentLabel.sizeThatFits(labelMaxSize).height
        let maxHeight = max(labelHeight, imageSize.height.cgValue)
        return .init(width: size.width, height: maxHeight)
    }
    
}
