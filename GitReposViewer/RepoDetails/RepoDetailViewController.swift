//
//  RepoDetailViewController.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    
    //MARK:- Properties
    var repositoryName, ownerName, ownerAvatar, createionDate, contributors, forks, branches: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        title = repositoryName
        avatarImageView.loadImage(from: ownerAvatar)
        ownerNameLabel.text = ownerName
        creationDateLabel.text = createionDate
    }
}
