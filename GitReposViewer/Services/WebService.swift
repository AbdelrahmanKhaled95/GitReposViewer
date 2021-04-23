//
//  WebService.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class WebSerice: WebServiceProtocol {
    
    func getRequest<ResponseType>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping ([ResponseType]?, Error?) -> Void) where ResponseType : Decodable {
        <#code#>
    }
    
    

}
