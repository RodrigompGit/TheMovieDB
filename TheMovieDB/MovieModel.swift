//
//  MovieModel.swift
//  WebAPIChallenge
//
//  Created by Bruno Fulber Wide on 17/06/17.
//  Copyright © 2017 BW. All rights reserved.
//

import Foundation

class MovieModel {
    
    static var shared = MovieModel()
    
    private init() {
        self.load {
            print("loaded all movie lists")
        }
    }
    
    let api_key = "7ee9b443aa187e3537589cc0b8a80a8b&language"
    
    var nowPlaying: [Movie] = []
    var upcoming: [Movie] = []
    var popular: [Movie] = []
    
    private func load(response: @escaping (Void) -> Void ){
        self.loadIDs(for: "now_playing", result: { self.loadMovies(with: $0, result: { self.nowPlaying = $0 }) })
        sleep(1)
        self.loadIDs(for: "popular", result: { self.loadMovies(with: $0, result: { self.popular = $0 }) })
        sleep(1)
        self.loadIDs(for: "upcoming", result: {
            self.loadMovies(with: $0, result: { self.upcoming = $0 })
            response()
        })
    }
    
    
    private func loadMovies(with idList: [String], result: ([Movie])->Void ){
        var answer : [Movie] = []
        
        for id in idList {
            usleep(100) // 40 requests /s
            let url =
            URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(api_key)&language=en-US")!
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let data = jsonData as? Dictionary<String, AnyObject> {
                        answer.append( Movie(with: data) )
                    }
                
                } catch let error {
                    print(error)
                }
                
            }.resume()
        }
        result(answer)
    }
    
    private func loadIDs(for category: String, result: @escaping ([String]) -> Void) {
        
        let url =
        URL(string: "https://api.themoviedb.org/3/movie/\(category)?api_key=\(api_key)&language=en-US&page=1")!
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dict = jsonData as? Dictionary<String, AnyObject> {
                    
                    let dictArray = dict["results"] as! [Dictionary<String, AnyObject>]
                    
                    
                    var idList: [String] = []
                    
                    for movie in dictArray {
                        idList.append( (movie["id"] as! Int).description )
                    }
                    
                    result(idList)
                    
                }else{
                    print("couldn't convert")
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
