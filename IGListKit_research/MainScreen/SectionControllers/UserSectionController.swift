//
//  UserSectionController.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import IGListKit

class UserSectionController: ListSectionController {
    private var user: User?
    private let isReorderable: Bool
    
    required init(isReorderable: Bool = false) {
        self.isReorderable = isReorderable
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: UserCell.self, for: self, at: index) as? UserCell else {
            fatalError()
        }
        cell.title = user?.name
        cell.detail = "@" + (user?.handle ?? "")
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.user = object as? User
    }
    
    override func canMoveItem(at index: Int) -> Bool {
        return isReorderable
    }
}
