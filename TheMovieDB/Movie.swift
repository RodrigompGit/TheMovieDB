//
//  Movie.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

struct Movie {

    var data : Dictionary<String, AnyObject>
    
    var id : String!
    var title : String!
    
    //this
    lazy var poster : UIImage? = {
        print("loaded poster")
        return self.loadImage(at: self.data["poster_path"] as? String)
    }()
    
    var backdrop : UIImage?
    var releaseDate : String?
    var runtime : Int?
    var rating : Int?
    var overview : String?
    var genres : [String]?
    lazy var actors : [Actor]? = {
        return self.loadActors()
    }()
    //TODO: trailer
    
    private func loadActors() -> [Actor] {
        var loaded = false
        var actors : [Actor] = []
        let url =
        URL(string: "https://api.themoviedb.org/3/movie/\(self.id!)/credits?api_key=\(MovieModel.shared.api_key)")!
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let jsonData = json as? Dictionary<String, AnyObject> {
                    if let cast = jsonData["cast"] as? [Dictionary<String, AnyObject>] {
                        for actorData in cast {
                            actors.append( Actor(with: actorData) )
                        }
                    }
                }
            } catch let error {
                print("error: \(error)")
            }
            loaded = true
        }.resume()
        
        while true {
            if loaded { break }
        }
        
        return actors
    }
    
    private func loadImage(at path: String?, resolution: String = "original") -> UIImage? {
        
        if path == nil { return nil }
        
        let url = URL(string: "https://image.tmdb.org/t/p/\(resolution)" + path! )
        
        if let data = try? Data(contentsOf: url!) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    init(with data: Dictionary<String, AnyObject>){
        
        self.data = data
        
        //initialize non optional variables
        self.id = (data["id"] as! Int).description
        self.title = data["original_title"] as! String
        
        //initialize optional variables
        
        
        //or this?
        //load backdrop
        self.backdrop = loadImage(at: data["backdrop_path"] as? String)
        
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
        
        //load overview
        if let overview = data["overview"] as? String {
            self.overview = overview
        }
        
        //load genres
        if let genres = data["genres"] as? [Dictionary<String, Any>] {
            self.genres = []
            for genre in genres{
                self.genres?.append( genre["name"] as! String )
            }
        }
    }
}
