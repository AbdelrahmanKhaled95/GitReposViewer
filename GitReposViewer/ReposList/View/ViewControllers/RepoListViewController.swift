//
//  RepoListViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class RepoListViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:-Properties
    var genericTableView: GenericTableView<RepoListCellViewModel, RepositoryTableViewCell>!
    lazy var viewModel: RepositoryViewModel = {
        return RepositoryViewModel()
    }()
    private var selectedRepository: RepoListCellViewModel?
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GitHub Repos"
        genericTableView = GenericTableView(frame: tableViewContainer.bounds, items: viewModel.repoListCellViewModels, config: configRepoTable, selectHandler: selectHelper)
        tableViewContainer.addSubview(genericTableView)
        setupBinding()
    }
    //MARK:- Setup binding
    func setupBinding() {
        viewModel.showAlert = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let message = self.viewModel.errorMessage {
                    self.showAlert(message)
                }
            }
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activitySpinner.stopAnimating()
                    UIView.animate(withDuration: 0.1, animations: {
                        self.genericTableView.alpha = 0.0
                        self.activitySpinner.isHidden = true
                    })
                case .loading:
                    self.activitySpinner.startAnimating()
                    UIView.animate(withDuration: 0.1, animations: {
                        self.genericTableView.alpha = 0.0
                        self.activitySpinner.isHidden = false
                    })
                case .filled:
                    self.activitySpinner.stopAnimating()
                    UIView.animate(withDuration: 0.1, animations: {
                        self.genericTableView.alpha = 1.0
                        self.activitySpinner.isHidden = true
                    })
                }
            }
        }
        viewModel.reloadTableView = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.genericTableView.reloadTable(data: self.viewModel.repoListCellViewModels)
            }
        }
        viewModel.initalFetchGitHubRepositories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK:- Generic TableView closures
extension RepoListViewController {
    func configRepoTable(item: RepoListCellViewModel, cell: RepositoryTableViewCell) {
        cell.repoListCellViewModel = item
    }
    func selectHelper(item: RepoListCellViewModel) {
        print(item.repositoryName)
    }
}
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
//MARK:- Navigation
extension RepoListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let repositoryDetailsVC = segue.destination as? RepoDetailViewController,
            let repository = selectedRepository {
            repositoryDetailsVC.ownerAvatar = repository.ownerAvatar
            repositoryDetailsVC.repositoryName = repository.repositoryName
            repositoryDetailsVC.ownerName = repository.ownerName
            repositoryDetailsVC.createionDate = repository.creationDate
        }
    }
}
