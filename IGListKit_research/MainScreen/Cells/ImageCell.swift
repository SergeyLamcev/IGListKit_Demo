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
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        contentView.addSubview(postText)
        postText.backgroundColor = .blue
        postText.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(contentView.frame.width / 2)
        }
        contentView.addSubview(postImage)
        postImage.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(contentView.frame.width / 2)
        }
    }
}

extension ImageCell: ListBindable {
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ImagePost else { return }
        postText.text = viewModel.text
    }
    
}
