//
//  ViewController.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController, ListAdapterDataSource, ListAdapterMoveDelegate {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 44.0, height: 44.0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(red: 0.831_372_549, green: 0.945_098_039, blue: 0.964_705_882, alpha: 1)
        return collectionView
    }()
    
    // NOTE: id should be unique or will throw exeption
    var data: [Any] = generateCollectionViewData()
    var lastItemId: Int = 0
    
    static func generateCollectionViewData() -> [Any] {
        let itemsIndexes = Array(1...30)
        var result: [Any] = []
        for index in itemsIndexes {
            result.append(ImagePost(id: index, text: "text \(index)", imageURL: "https://picsum.photos/300/300/?image=\(index)"))
//            result.append(User(pk: index+itemsIndexes.last!, name: "Ryan \(index)" , handle: "ryanolsonk \(index)"))
        }
        return result
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func setupLayout() {
        configureNavBar()
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        adapter.collectionView = collectionView
        adapter.dataSource = self
        if #available(iOS 9.0, *) {
            adapter.moveDelegate = self
        }
    }
    
    func configureNavBar() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        self.title = "IGListKit_Demo"
    }
    
    @objc func addTapped(){
        guard let lastItem = data.last! as? User else {
            return
        }
        debugPrint("Tap")
        data.append(User(pk: lastItem.pk + 1, name: "Petuh \(lastItem.pk + 1)" , handle: "Petuh \(lastItem.pk + 1)"))
        adapter.reloadData(completion: nil)
    }
    
    // MARK: IGListKit - ListAdapterDataSource, ListAdapterMoveDelegate
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data.map { $0 as! ListDiffable }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is User:
            return UserSectionController()
        default:
            return ImageSectionController(isReorderable: false)
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func listAdapter(_ listAdapter: ListAdapter, move object: Any, from previousObjects: [Any], to objects: [Any]) {
        data = objects
    }
    
}

