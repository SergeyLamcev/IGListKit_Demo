//
//  DiffTableViewController.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/14/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import IGListKit
import UIKit

final class Person: ListDiffable {
    
    let pk: Int
    let name: String
    
    init(pk: Int, name: String) {
        self.pk = pk
        self.name = name
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return pk as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Person else { return false }
        return self.name == object.name
    }
    
}

final class DiffTableViewController: UITableViewController {
    
    var oldPeople = generetePeoples()

    lazy var people: [Person] = {
        return self.oldPeople
    }()
    
    static func generetePeoples() -> [Person] {
        let elements = Array(1...100)
        var peoples: [Person] = []
        for number in elements {
            peoples.append(Person(pk: number, name: "New user \(number)"))
        }
        return peoples
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                            target: self,
                                                            action: #selector(DiffTableViewController.onDiff))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func onDiff() {
        
        var newPeople = oldPeople
        debugPrint(oldPeople.count)
        newPeople.append(Person.init(pk: oldPeople.count + 1, name: "New user + \(oldPeople.count + 1)"))
        people = newPeople
        
        let result = ListDiffPaths(fromSection: 0, toSection: 0, oldArray: oldPeople, newArray: newPeople, option: .equality).forBatchUpdates()
        debugPrint(result.inserts)
        tableView.beginUpdates()
        tableView.deleteRows(at: result.deletes, with: .none)
        tableView.insertRows(at: result.inserts, with: .none)
        result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
        tableView.endUpdates()
        oldPeople = newPeople
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row].name
        return cell
    }
    
}
