//
//  GenericCollectionView+Extension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

extension GenericCollectionViewController {
    func registerNib() {
        let nibName = "\(Cell.self)"
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
