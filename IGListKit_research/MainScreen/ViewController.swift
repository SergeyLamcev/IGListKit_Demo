//
//  ViewController.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController, ListAdapterDataSource, ListAdapterMoveDelegate, ListSingleSectionControllerDelegate {
    
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
    var dataOld: [ImagePost] = generateCollectionViewData()
    
    static func generateCollectionViewData() -> [ImagePost] {
        let itemsIndexes = Array(1...70)
        var result: [ImagePost] = []
        for index in itemsIndexes {
            result.append(ImagePost(id: index, text: "text \(index)", imageURL: "https://picsum.photos/300/300/?image=\(index)"))
        }
        return result
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UICollectionView.appearance().isPrefetchingEnabled = false
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
    
    @objc func addTapped() {
        
        dataOld.append(ImagePost.init(id: dataOld.count+1, text: "New post \(dataOld.count+1)", imageURL: "https://picsum.photos/300/300/?image=\(dataOld.count+1)"))
        
        debugPrint(collectionView.numberOfSections)
//        let result = ListDiffPaths(fromSection: 0, toSection: collectionView.numberOfSections-1, oldArray: dataOld, newArray: newData, option: .equality).forBatchUpdates()
        
        adapter.performUpdates(animated: true, completion: nil)

//        collectionView.performBatchUpdates({
//            collectionView.deleteItems(at:  result.deletes)
//            collectionView.insertItems(at:  result.inserts)
//            collectionView.reloadItems(at:  result.updates)
//            result.moves.forEach { move in
//                collectionView.moveItem(at: move.from, to: move.to)
//            }
//        }, completion: nil)
        
    }
    
    // MARK: IGListKit - ListAdapterDataSource, ListAdapterMoveDelegate
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataOld
    }
    
    func listAdapter(_ listAdapter: ListAdapter, move object: Any, from previousObjects: [Any], to objects: [Any]) {
        dataOld = objects as! [ImagePost]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        default:
            let configureBlock = { (item: Any, cell: UICollectionViewCell) in
                guard let cell = cell as? ImageCell, let post = item as? ImagePost else { return }
                cell.postText.text = post.text
            }
            
            let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
                guard let context = context else { return CGSize() }
                return CGSize(width: context.containerSize.width, height: 44)
            }
            let controller = ImageSectionController(cellClass: ImageCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
            controller.selectionDelegate = self
            return controller
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    // MARK: ListSingleSectionControllerDelegate
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        let section = adapter.section(for: sectionController) + 1
        let alert = UIAlertController(
            title: "Section \(section) was selected \u{1F389}",
            message: "Cell Object: " + String(describing: object),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
