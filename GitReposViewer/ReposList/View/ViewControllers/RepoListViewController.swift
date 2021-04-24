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
    var genericTableView: GenericTableView<RepoListCellViewModel, RepositoryTableViewCell>?
    lazy var viewModel: RepositoryViewModel = {
        return RepositoryViewModel()
    }()
    var selectedRepository: RepoListCellViewModel?
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GitHub Repos"

        setupGenericTableView()
        setupBinding()
    }
    
    func setupGenericTableView() {
        genericTableView = GenericTableView(frame: tableViewContainer.bounds, items: viewModel.repoListCellViewModels, config: configRepoTable, selectHandler: selectHelper, prefetch: nil)
        if let genericTableView = genericTableView{
            tableViewContainer.addSubview(genericTableView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
