//
//  JSONParser.swift
//  fav-movie
//
//  Created by kev on 7.06.2017.
//  Copyright © 2017 aniltaskiran. All rights reserved.
//

import Foundation

class JSONParser {

    static func parse (data: Data) -> [String: AnyObject]? {

        let options = JSONSerialization.ReadingOptions()
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: options) as? [String: AnyObject]
            
            return json!
        } catch (let parseError){
            print("There was an error parsing the JSON: \"\(parseError.localizedDescription)\"")
        }
        return nil
    }
}
