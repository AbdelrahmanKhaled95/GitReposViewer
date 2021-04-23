//
//  GenericTableView.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

class GenericTableView<Item, Cell: UITableViewCell>: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Properties
    var items: [Item]
    var config: (Item, Cell) -> Void
    var selectHandler: (Item) -> Void
    
    init(frame: CGRect, items: [Item], config: @escaping (Item, Cell) -> Void, selectHandler: @escaping (Item) -> Void) {
        self.items = items
        self.config = config
        self.selectHandler = selectHandler
        super.init(frame: frame, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = delegate
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectHandler(items[indexPath.row])
    }
}
