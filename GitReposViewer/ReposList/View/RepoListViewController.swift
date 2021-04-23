//
//  ViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class RepoListViewController: UIViewController {
    
    //MARK:-Properties
    var genericTableView: GenericTableView<String, UITableViewCell>!
    var data = Array(repeating: "Abdo", count: 10)
    let viewModel = RepositoryViewModel(webService: WebSerice())
    
    //MARK:- Outlets
    @IBOutlet weak var tableViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        genericTableView = GenericTableView(frame: tableViewContainer.bounds, items: data, config: { (name, cell) in
            cell.textLabel?.text = name
        }, selectHandler: { (name) in
            print(name)
        })
        tableViewContainer.addSubview(genericTableView)
        viewModel.fetchGitHubRepositories()
    }


}

