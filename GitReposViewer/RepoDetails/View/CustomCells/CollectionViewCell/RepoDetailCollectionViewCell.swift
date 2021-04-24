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
    
    var forkListCellViewModel : ForkListCellViewModel? {
        didSet {
            ownerNameLabel.text = forkListCellViewModel?.ownerName
            avatarImageView?.loadImage(from: forkListCellViewModel?.avatarImage)
        }
    }
    
    var contributorListCellViewModel : ContributorListCellViewModel? {
        didSet {
            ownerNameLabel.text = contributorListCellViewModel?.ownerName
            avatarImageView?.loadImage(from: contributorListCellViewModel?.avatarImage)
        }
    }
}
