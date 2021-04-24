//
//  RepoDetailCollectionViewCell.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class RepoDetailCollectionViewCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    override func prepareForReuse() {
        ownerNameLabel.text = ""
        avatarImageView.image = nil
    }
    
    var repoDetailsCollectionCellViewModel : RepoDetailsCollectionCellViewModel? {
        didSet {
            ownerNameLabel.text = repoDetailsCollectionCellViewModel?.ownerName
            avatarImageView?.loadImage(from: repoDetailsCollectionCellViewModel?.avatarImage)
        }
    }
    
}
