//
//  ListSectionController.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import IGListKit
import Kingfisher

protocol ImageSectionControllerDelegate: class {
    func addNewItem(context: ListCollectionContext?)
}

class ImageSectionController: ListSingleSectionController {
    
    weak var delegate: ImageSectionControllerDelegate?
    
    private var imagePost: ImagePost?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 100)
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
    
    func addNewItem() {
        delegate?.addNewItem(context: collectionContext)
    }
}
