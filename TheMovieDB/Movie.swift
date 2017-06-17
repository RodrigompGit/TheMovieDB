//
//  Movie.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class Movie {

    var title : String!
    var poster : UIImage?
    var actors : [Actor]?
    var releaseDate : Date?
    var categories : [String]?
    
    init() {
        self.title = "Teste"
        self.poster = #imageLiteral(resourceName: "teste")
    }
    
    
}
