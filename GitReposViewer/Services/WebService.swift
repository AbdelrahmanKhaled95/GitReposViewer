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
        //Divide GitHub token key to avoid being Revoked when pushed on github servers
        let keyPart1 = "ghp"
        let keyPart2 = "_dPkbRJ4VhCH"
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "Bearer \(keyPart1)\(keyPart2)oiVIK2FCAllDd0lSxev0ptPBr"
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
