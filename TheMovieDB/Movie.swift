//
//  Movie.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

struct Movie {

    //core
    var data : Dictionary<String, AnyObject>
    var id : String!
    var title : String!
    
    
    //images
    lazy var poster : UIImage? = {
       return self.loadImage(at: self.data["poster_path"] as? String, resolution: "w342")
    }()
    
    lazy var backdrop : UIImage? = {
        return self.loadImage(at: self.data["backdrop_path"] as? String , resolution: "w780")
    }()
    
    //details screen
    var releaseDate : String?
    var rating : Int?
    var overview : String?
    var genres : [String]?
    var actors : [Actor]?
    //TODO: trailer
    
    func loadActors(completion: @escaping ([Actor]) -> Void) {
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
            completion(actors)
        }.resume()
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
        self.id = (data["id"] as! Int).description
        self.title = data["original_title"] as! String
        self.releaseDate = data["release_date"] as? String ?? nil
        self.rating = data["vote_average"] as? Int ?? nil
        self.overview = data["overview"] as? String ?? nil
        self.genres = []
        
        if let genres = self.data["genres"] as? [Dictionary<String, Any>] {
            for genre in genres{
                self.genres?.append(genre["name"] as! String)
            }
        }
    }
}
