//
//  HTTPHandler.swift
//  fav-movie
//
//  Created by kev on 7.06.2017.
//  Copyright © 2017 aniltaskiran. All rights reserved.
//

import Foundation

class HTTPHandler {
    static func getJson(urlString: String, completionHandler: @escaping (Data?) -> (Void)){
        
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        print("URL being used is \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {data, response, error in
        if let data = data {
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print("request completed with code: \(statusCode)")
            if(statusCode == 200){
                print("return to completion handler with data")
                completionHandler(data as Data)
            }
        } else if let error = error {
            print("***There was an error making the HTTP request***")
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
        task.resume()
}
}
