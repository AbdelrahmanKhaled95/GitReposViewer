//
//  GenericCollectionViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class GenericCollectionViewController<Item, Cell: UICollectionViewCell>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK:- Properties
    var items: [Item]
    var config: (Item, Cell) -> Void
    //MARK:- Initializer
    init(frame: CGRect, items: [Item], config: @escaping (Item, Cell) -> Void) {
        self.items = items
        self.config = config
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: self.contentSize.width/5, height: self.contentSize.height/3)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.registerNib()
        self.backgroundColor = .white
        self.isPagingEnabled = true
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
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
}
//MARK:- Reload Table
extension GenericCollectionViewController {
    func reloadTable(data items: [Item]) {
        self.items = items
        self.reloadData()
    }
}
