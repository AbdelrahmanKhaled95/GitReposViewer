//
//  ViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var genericTableView: GenericTableView<String, UITableViewCell>!
    let data = Array(repeating: "Abdo", count: 10)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        genericTableView = GenericTableView(frame: <#T##CGRect#>, items: <#T##[_]#>, config: <#T##(_, UITableViewCell) -> Void#>, selectHandler: <#T##(_) -> Void#>)
        // Do any additional setup after loading the view.
    }


}

