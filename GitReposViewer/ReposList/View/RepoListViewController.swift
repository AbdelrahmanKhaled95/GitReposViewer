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
    
    //MARK:-Properties
    var genericTableView: GenericTableView<RepoListCellViewModel, RepositoryTableViewCell>!
    lazy var viewModel: RepositoryViewModel = {
        return RepositoryViewModel()
    }()
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GitHub Repos"
        genericTableView = GenericTableView(frame: tableViewContainer.bounds, items: viewModel.repoListCellViewModels, config: configRepoTable, selectHandler: selectHelper)
        tableViewContainer.addSubview(genericTableView)
        setupBinding()
    }
    
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
                    UIView.animate(withDuration: 0.3, animations: {
                        self.genericTableView.alpha = 0.0
                        self.activitySpinner.isHidden = true
                    })
                case .loading:
                    self.activitySpinner.startAnimating()
                    UIView.animate(withDuration: 0.3, animations: {
                        self.genericTableView.alpha = 0.0
                        self.activitySpinner.isHidden = false
                    })
                case .filled:
                    self.activitySpinner.stopAnimating()
                    UIView.animate(withDuration: 0.3, animations: {
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

extension RepoListViewController {
    func configRepoTable(item: RepoListCellViewModel, cell: RepositoryTableViewCell) {
        cell.repoListCellViewModel = item
    }
    
    func selectHelper(item: RepoListCellViewModel) {
        
    }
}

