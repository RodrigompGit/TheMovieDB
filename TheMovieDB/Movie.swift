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
    
    init(with data: Dictionary<String, AnyObject>){
        self.title = data["original_title"] as! String
        
        //initialize poster if request is sucessfull
        let posterURL =
        URL(string: "https://image.tmdb.org/t/p/w185" + (data["poster_path"] as! String) )
        
        if let posterData = try? Data(contentsOf: posterURL!) {
            
            self.poster = UIImage(data: posterData)
            
        } else {
            print("error initializing poster")
        }
    }
    
    
}
