//
//  ListSectionController.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import IGListKit
import Kingfisher

class ImageSectionController: ListSectionController {
    private var imagePost: ImagePost?
    private let isReorderable: Bool
    
    required init(isReorderable: Bool = false) {
        self.isReorderable = isReorderable
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as? ImageCell else {
            fatalError()
        }
        cell.postText.text = imagePost?.text
        cell.postImage.kf.setImage(with: URL(string: imagePost?.imageURL ?? ""))
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.imagePost = object as? ImagePost
    }
    
    override func canMoveItem(at index: Int) -> Bool {
        return isReorderable
    }
}
