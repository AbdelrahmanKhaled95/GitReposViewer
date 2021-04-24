//
//  RepoDetailViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contributorViewContainer: UIView!
    @IBOutlet weak var branchListTableViewController: UIView!
    @IBOutlet weak var forkCollectionViewController: UIView!
    
    
    //MARK:- Properties
    var repositoryName, ownerName, ownerAvatar, createionDate, contributors, forks, branches: String?
    var genericTableView: GenericTableView<BranchesListCellViewModel, UITableViewCell>?
    lazy var viewModel: RepoDetailsViewModel = {
        return RepoDetailsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        // Do any additional setup after loading the view.
    }
    
    func setupGenericTableView() {
        genericTableView = GenericTableView(frame: branchListTableViewController.bounds, items: viewModel.branchListCellViewModel, config: configRepoTable, selectHandler: selectHelper)
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
