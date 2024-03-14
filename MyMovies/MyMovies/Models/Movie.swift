//
//  Movie.swift
//  MyMovies
//
//  Created by Jurymar Colmenares on 11/03/24.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}
