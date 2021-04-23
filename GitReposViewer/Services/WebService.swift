//
//  WebService.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class WebSerice: WebServiceProtocol {
    
    //MARK:- Custom Session
    var session = URLSession.shared
    
    init() {
        // GitHib Authorization Key
        let key = "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"
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "Bearer \(key)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
    }

    
    //MARK:- Get Method
    func getRequest<ResponseType>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?) -> Void) where ResponseType : Decodable {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result, nil)
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    print(error)
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func getRequestArray<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping ([ResponseType]?, Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            do {
                let result = try JSONDecoder().decode([ResponseType].self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result, nil)
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    print(error)
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
}
