//
//  ImageCell.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

class ImageCell: UICollectionViewCell {
    
    let postText = UILabel()
    let postImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        contentView.addSubview(postText)
        postText.font = UIFont.systemFont(ofSize: CGFloat.random(in: 40..<50))
        postText.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
//            make.right.equalTo(postText.snp.right)
        }
//        contentView.addSubview(postImage)
//        postImage.clipsToBounds = true
//        postImage.snp.makeConstraints { (make) in
//            make.top.right.bottom.equalToSuperview()
//            make.left.equalTo(postText.snp.right)
//        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
}

extension ImageCell: ListBindable {
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ImagePost else { return }
        postText.text = viewModel.text
    }
    
}
