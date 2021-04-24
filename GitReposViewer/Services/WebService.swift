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
        let key = "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"
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "Bearer \(key)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
    }
    
    
    //MARK:- Get Method
    func getRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
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
                print(error)
                let gitHubError = try? JSONDecoder().decode(GitHubErrorMessage.self, from: data)
                DispatchQueue.main.async {
                    if let gitHubError = gitHubError {
                        completionHandler(nil, gitHubError)
                    } else {
                        completionHandler(nil, error)
                    }
                }
                return
            }
        }
        task.resume()
    }
    
    func getRequestArray<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping ([ResponseType]?, Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
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
                let gitHubError = try? JSONDecoder().decode(GitHubErrorMessage.self, from: data)
                DispatchQueue.main.async {
                    if let gitHubError = gitHubError {
                        completionHandler(nil, gitHubError)
                    } else {
                        completionHandler(nil, error)
                    }
                }
                return
            }
        }
        task.resume()
    }
}
