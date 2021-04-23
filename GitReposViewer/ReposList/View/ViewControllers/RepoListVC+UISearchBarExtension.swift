//
//  RepoListVC+UISearchBarExtension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- SearchBar Actions
extension RepoListViewController: UISearchBarDelegate {
    // Called when clicked on search key in keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchValue = searchBar.text {
            viewModel.serachForRepo(searchValue: searchValue)
        }
    }
    // Called when clicked on clear button
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.initalFetchGitHubRepositories()
        }
    }
}
