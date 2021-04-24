//
//  RepoDetailViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class RepoDetailViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var contributorViewContainer: UIView!
    @IBOutlet weak var branchListTableViewController: UIView!
    @IBOutlet weak var forkCollectionViewController: UIView!
    
    
    //MARK:- Properties
    var repositoryName, ownerName, ownerAvatar, createionDate, contributors, forks, branches: String?
    var genericTableView: GenericTableView<BranchesListCellViewModel, BranchTableViewCell>?
    var forkGenericCollectionView: GenericCollectionViewController<ForkListCellViewModel,RepoDetailCollectionViewCell>?
    var contributorGenericCollectionView: GenericCollectionViewController<ContributorListCellViewModel,RepoDetailCollectionViewCell>?
    lazy var viewModel: RepoDetailsViewModel = {
        return RepoDetailsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGenericTableView()
        setupGenericCollectionView()
        setupView()
        setupBinding()
    }
    
    func setupGenericCollectionView() {
        forkGenericCollectionView = GenericCollectionViewController(frame: forkCollectionViewController.bounds, items: viewModel.forkListCellViewModel, config: configForkCollection, prefetch: prefetchFork)
        contributorGenericCollectionView = GenericCollectionViewController(frame: forkCollectionViewController.bounds, items: viewModel.contributorListCellViewModel, config: configContributorCollection, prefetch: prefetchContributor)
        if let forkGenericCollectionView = forkGenericCollectionView, let contributorGenericCollectionView = contributorGenericCollectionView {
            forkCollectionViewController.addSubview(forkGenericCollectionView)
            contributorViewContainer.addSubview(contributorGenericCollectionView)
        }
    }
    
    func setupGenericTableView() {
        genericTableView = GenericTableView(frame: branchListTableViewController.bounds, items: viewModel.branchListCellViewModel, config: configRepoTable, selectHandler: nil, prefetch: prefetchBranch)
        if let genericTableView = genericTableView{
            branchListTableViewController.addSubview(genericTableView)
        }
    }
    
    func setupView() {
        title = repositoryName
        avatarImageView.loadImage(from: ownerAvatar)
        ownerNameLabel.text = ownerName
        creationDateLabel.text = createionDate
    }
}
