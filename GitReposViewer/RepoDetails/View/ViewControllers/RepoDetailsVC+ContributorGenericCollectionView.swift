//
//  RepoDetailsVC+ContributorGenericCollectionView.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation

//MARK:- Generic CollectionView closures
extension RepoDetailViewController {
    func configContributorCollection(item: ContributorListCellViewModel, cell: RepoDetailCollectionViewCell) {
        cell.contributorListCellViewModel = item
    }
    
    func prefetchContributor() {
        guard let ownerName = ownerName, let repositoryName = repositoryName else { return }
        viewModel.fetchRepoContributors(ownerName: ownerName, repositoryName: repositoryName)
    }
}

