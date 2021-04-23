//
//  UIImageView+Extension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
