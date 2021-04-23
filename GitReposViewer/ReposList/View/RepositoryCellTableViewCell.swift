//
//  RepositoryCellTableViewCell.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class RepositoryCellTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var RepositoryName: UILabel!
    @IBOutlet weak var OwnerAvatar: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    
    @IBOutlet weak var CreationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
