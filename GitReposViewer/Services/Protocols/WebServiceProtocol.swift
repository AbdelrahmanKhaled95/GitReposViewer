//
//  WebServiceProtocol.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

protocol WebServiceProtocol {
    func getRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping ([ResponseType]?, Error?)-> Void)
}
