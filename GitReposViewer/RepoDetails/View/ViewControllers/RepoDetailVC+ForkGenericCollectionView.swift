//
//  RepoDetailVC+GenericForksListCollectionView.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- Generic CollectionView closures
extension RepoDetailViewController {
    func configForkCollection(item: ForkListCellViewModel, cell: RepoDetailCollectionViewCell) {
        cell.forkListCellViewModel = item
    }
    
    func prefetchFork() {
        guard let ownerName = ownerName, let repositoryName = repositoryName else { return }
        viewModel.fetchRepoForks(ownerName: ownerName, repositoryName: repositoryName)
        
    }
}
