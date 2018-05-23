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
    
    let actionLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor.blue
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
        i.sizeToFit()
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
        
        nal.layout(optionsLabel, by: { $0
            .setTopRight(by: { $0.topRight })
            .fitSize()
        })
        nal.layout(actionLabel, by: { $0
            .setTopLeft(by: { $0.topLeft })
            .fitSize()
            .pinchingRight(to: { (frame, _) in
                NotAutoLayout.Float(min(frame.right.cgValue, self.optionsLabel.frame.minX))
            })
        })

        nal.layout(posterImageView, by: { $0
            .pinTopLeft(to: actionLabel, with: { $0.bottomLeft })
            .fitSize()
        })
        nal.layout(posterNameLabel, by: { $0
            .pinTopLeft(to: posterImageView, with: { $0.topRight + .init(x: 1, y: 0) })
            .setRight(by: { $0.right - 3 })
            .fitHeight()
        })

        nal.layout(posterHeadlineLabel) { $0
            .pinLeft(to: posterImageView, with: { $0.right + 1 })
            .setRight(by: { $0.right - 3 })
            .pinTop(to: posterNameLabel, with: { $0.bottom + 1 })
            .fitHeight()
        }

        nal.layout(posterTimeLabel, by: { $0
            .pinLeft(to: posterImageView, with: { $0.right + 1 })
            .setRight(by: { $0.right - 3 })
            .pinTop(to: posterHeadlineLabel, with: { $0.bottom + 1 })
            .fitHeight()
        })

        nal.layout(posterCommentLabel, by: { $0
            .setCenter(by: { $0.center })
            .setTop(by: { _ in NotAutoLayout.Float(max(self.posterImageView.frame.maxY, self.posterTimeLabel.frame.maxY + 2)) })
            .setWidth(by: { $0.width })
            .fitHeight()
        })

        nal.layout(contentImageView, by: { $0
            .setCenter(by: { $0.center })
            .pinTop(to: posterCommentLabel, with: { $0.bottom })
            .fitSize()
        })
        
        nal.layout(contentTitleLabel, by: { $0
            .setCenter(by: { $0.center })
            .pinTop(to: contentImageView, with: { $0.bottom })
            .setWidth(by: { $0.width })
            .fitHeight()
        })
        
        nal.layout(contentDomainLabel, by: { $0
            .setCenter(by: { $0.center })
            .pinTop(to: contentTitleLabel, with: { $0.bottom })
            .setWidth(by: { $0.width })
            .fitHeight()
        })
        
        nal.layout(likeLabel, by: { $0
            .pinTopLeft(to: contentDomainLabel, with: { $0.bottomLeft })
            .fitSize()
        })
        
        nal.layout(commentLabel, by: { $0
            .pinTopCenter(to: contentDomainLabel, with: { $0.bottomCenter })
            .fitSize()
        })
        
        nal.layout(shareLabel, by: { $0
            .pinTopRight(to: contentDomainLabel, with: { $0.bottomRight })
            .fitSize()
        })
        
        nal.layout(actorImageView, by: { $0
            .pinTopLeft(to: likeLabel, with: { $0.bottomLeft })
            .fitSize()
        })
        
        nal.layout(actorCommentLabel, by: { $0
            .pinTopLeft(to: actorImageView, with: { $0.topRight })
            .setRight(by: { $0.right })
            .fitHeight()
        })
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layoutSubviews()
        return CGSize(width: size.width, height: max(actorImageView.frame.bottom, actorCommentLabel.frame.bottom))
    }
    
    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
    
}
