//
//  WebService.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class WebSerice: WebServiceProtocol {
    
    func getRequest<ResponseType>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping ([ResponseType]?, Error?) -> Void) where ResponseType : Decodable {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            do {
                let repoList = try JSONDecoder().decode([ResponseType].self, from: data)
                DispatchQueue.main.async {
                    completionHandler(repoList, nil)
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    
}
