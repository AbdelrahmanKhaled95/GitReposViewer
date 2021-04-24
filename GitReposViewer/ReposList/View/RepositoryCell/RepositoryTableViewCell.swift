//
//  RepositoryTableViewCell.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    
    override func prepareForReuse() {
        repositoryName.text = ""
        ownerName.text = ""
        creationDate.text = ""
        ownerAvatar.image = nil
    }
    
    var repoListCellViewModel : RepoListCellViewModel? {
        didSet {
            repositoryName.text = repoListCellViewModel?.repositoryName
            ownerName.text = repoListCellViewModel?.ownerName
            creationDate.text = repoListCellViewModel?.creationDate
            ownerAvatar?.loadImage(from: repoListCellViewModel?.ownerAvatar)
        }
    }
}
