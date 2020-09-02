// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import AsyncDisplayKit

class TextureCollectionViewController: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {

    let collectionNode: ASCollectionNode
    let reuseIdentifier = "cell"
    let data: [FeedItemData]
    let flowLayout: UICollectionViewFlowLayout

    init(data: [FeedItemData]) {
        self.data = data
        self.flowLayout = UICollectionViewFlowLayout()
        self.collectionNode = ASCollectionNode(collectionViewLayout: self.flowLayout)
        super.init(node: collectionNode)
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionNode.reloadData()
    }

    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let cell = FeedItemTextureNode(data: data[indexPath.row])

        return cell
    }
}
