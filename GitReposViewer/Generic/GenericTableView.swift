//
//  GenericTableView.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class GenericTableView<Item, Cell: UITableViewCell>: UITableView, UITableViewDataSource {
    
    var items: [Item]
    var config: (Item, Cell) -> Void
    
    init(frame: CGRect, items: [Item], config: @escaping (Item, Cell) -> Void) {
        self.items = items
        self.config = config
        super.init(frame: frame, style: .plain)
        self.dataSource = self
        self.register(Cell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        config(items[indexPath.row], cell)
        return cell
    }
}
