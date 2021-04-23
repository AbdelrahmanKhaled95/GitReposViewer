//
//  ViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:-Properties
    var genericTableView: GenericTableView<String, UITableViewCell>!
    var data = [String]()
    let viewModel = RepositoryViewModel(webService: WebSerice())
    
    //MARK:- Outlets
    @IBOutlet weak var tableViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // tableViewContainer.addSubview(genericTableView)
        viewModel.fetchGitHubRepositories()
    }


}

