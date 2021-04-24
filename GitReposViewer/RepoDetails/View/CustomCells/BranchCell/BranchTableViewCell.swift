//
//  BranchTableViewCell.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

class BranchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var branchNameLabel: UILabel!
    
    override func prepareForReuse() {
        branchNameLabel.text = ""
    }
}
