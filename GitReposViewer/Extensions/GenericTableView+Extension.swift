//
//  UITableView+Extension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation
import UIKit

extension GenericTableView {
    func registerNib() {
        let nibName = "\(Cell.self)"
        self.register(Cell.self, forCellReuseIdentifier: nibName)
    }
    
    func dequeue() -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(Cell.self)") as? Cell else { fatalError("Can't Happen") }
        return cell
    }
}
