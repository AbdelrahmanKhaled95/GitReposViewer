//
//  RepoDetailVC+GenericForksListCollectionView.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- Generic CollectionView closures
extension RepoDetailViewController {
    func configRepoCollection(item: ForkListCellViewModel, cell: RepoDetailCollectionViewCell) {
        cell.forkListCellViewModel = item
    }
}
