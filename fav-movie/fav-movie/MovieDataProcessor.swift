//
//  MovieDataProcessor.swift
//  fav-movie
//
//  Created by kev on 7.06.2017.
//  Copyright © 2017 aniltaskiran. All rights reserved.
//

import Foundation

class MovieDataProcessor {
    static func mapJsonToMovies(object: [String: AnyObject], moviesKey: String) -> [Movie] {
        var mappedMovies: [Movie] = []
        
        guard let movies = object[moviesKey] as? [[String: AnyObject]] else { return mappedMovies }
        
        for movie in movies {
            guard let id = movie["imdbID"] as? String,
                let name = movie["Title"] as? String,
                let year = movie["Year"] as? String,
                let imageUrl = movie["Poster"] as? String else { continue }
            let movieClass = Movie(id: id, title: name, year: year, imageUrl: imageUrl)
            mappedMovies.append(movieClass)
            
        }
        return mappedMovies
        
    }
    static func write(movies: [Movie]){
        //TODO: Implement
    }

}
