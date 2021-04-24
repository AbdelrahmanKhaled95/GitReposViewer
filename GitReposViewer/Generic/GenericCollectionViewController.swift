//
//  GenericCollectionViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class GenericCollectionViewController<Item, Cell: UICollectionViewCell>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK:- Properties
    var items: [Item]
    var config: (Item, Cell) -> Void
    var selectHandler: (Item, Int) -> Void
    //MARK:- Initializer
    init(frame: CGRect, items: [Item], config: @escaping (Item, Cell) -> Void, selectHandler: @escaping (Item, Int) -> Void) {
        self.items = items
        self.config = config
        self.selectHandler = selectHandler
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        self.registerNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell else { fatalError() }
        config(items[indexPath.row], cell)
        return cell
    }
    //MARK:- Delegation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectHandler(items[indexPath.row], indexPath.row)
    }
}
//MARK:- Reload Table
extension GenericCollectionViewController {
    func reloadTable(data items: [Item]) {
        self.items = items
        self.reloadData()
    }
}
