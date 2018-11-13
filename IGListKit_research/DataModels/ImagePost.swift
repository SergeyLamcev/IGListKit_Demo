//
//  ImagePost.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import IGListKit

class ImagePost: ListDiffable {
    
    var id: Int
    var text: String
    var imageURL: String
    
    init(id: Int, text: String, imageURL: String) {
        self.id = id
        self.text = text
        self.imageURL = imageURL
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? ImagePost else { return false }
        return text == object.text && imageURL == object.imageURL
    }
}
