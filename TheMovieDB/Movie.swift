//
//  Movie.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class Movie {

    var id : String!
    var title : String!
    var poster : UIImage?
    var backdrop : UIImage?
    var releaseDate : String?
    var runtime : Int?
    var rating : Int?
    var genres : [String]?
    var actors : [Actor]? //TODO
    //TODO: short description
    
    init(with data: Dictionary<String, AnyObject>){
        
        //initialize non optional variables
        self.id = (data["id"] as! Int).description
        self.title = data["original_title"] as! String
        
        //initialize optional variables
        
        //load poster
        if let path = (data["poster_path"] as? String) {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/original" + path )
            loadImage(at: posterURL!, response: { self.poster = $0 })
        }
        
        //load backdrop
        if let path = (data["backdrop_path"] as? String) {
            let backdropURL = URL(string: "https://image.tmdb.org/t/p/original" + path )
            loadImage(at: backdropURL!, response: { self.backdrop = $0 })
        }
        
        //load release date
        if let release = data["release_date"] as? String {
            self.releaseDate = release
        }
        
        //load runtime
        if let runtime = data["runtime"] as? Int {
            self.runtime = runtime
        }
        
        //load rating
        if let rating = data["vote_average"] as? Int {
            self.rating = rating
        }
        
        //load genres
        if let genres = data["genres"] as? [Dictionary<String, Any>] {
            self.genres = []
            for genre in genres{
                self.genres?.append( genre["name"] as! String )
            }
        }
    }
    
    private func loadImage(at url: URL, response: (UIImage) -> Void) {
        if let imageData = try? Data(contentsOf: url) {
            
            response(UIImage(data: imageData)!)
            
        } else {
            print("error initializing image")
        }
    }
}
