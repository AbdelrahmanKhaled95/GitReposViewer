//
//  GenericCollectionViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class GenericCollectionViewController<Item, Cell: UICollectionViewCell>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {

    //MARK:- Properties
    var items: [Item]
    var config: (Item, Cell) -> Void
    var prefetch: () -> Void
    //MARK:- Initializer
    init(frame: CGRect, items: [Item], config: @escaping (Item, Cell) -> Void, prefetch: @escaping () -> Void) {
        self.items = items
        self.config = config
        self.prefetch = prefetch
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: self.contentSize.width/5, height: self.contentSize.height/3)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.prefetchDataSource = self
        self.registerNib()
        self.backgroundColor = .white
        self.isPagingEnabled = true
        self.isPrefetchingEnabled = true
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
    //MARK:- Prefetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= items.count - 5 {
                prefetch()
            }
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       self.collectionView(collectionView, prefetchItemsAt: [indexPath])
    }
}
//MARK:- Reload Table
extension GenericCollectionViewController {
    func reloadTable(data items: [Item]) {
        self.items = items
        self.reloadData()
    }
}
