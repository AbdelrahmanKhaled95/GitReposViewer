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
    
    //MARK:- Outlets
    @IBOutlet weak var tableViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genericTableView = GenericTableView(frame: tableViewContainer.bounds, items: data, config: { (item, cell) in
            cell.textLabel?.text = item
        }, selectHandler: { (item) in
            print(item)
        })
        // Do any additional setup after loading the view.
        tableViewContainer.addSubview(genericTableView)
    }
    


}

