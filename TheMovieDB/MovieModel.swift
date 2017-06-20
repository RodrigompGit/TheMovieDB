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
//        self.load {
//            self.didLoad = true
//            print("loaded all movies")
//        }
    }
    
    let api_key = "7ee9b443aa187e3537589cc0b8a80a8b&language"
    
    var nowPlaying: [Movie] = []
    var upcoming: [Movie] = []
    var popular: [Movie] = []
    
    var didLoad = false
    
//    private func load(response: @escaping (Void) -> Void ){
//        
//        DispatchQueue.main.async {
//            self.loadIDs(for: "now_playing") { self.loadMovies(with: $0, result: { self.nowPlaying = $0 }) }
//            sleep(1)
//            self.loadIDs(for: "popular") { self.loadMovies(with: $0, result: { self.popular = $0 }) }
//            sleep(1)
//            self.loadIDs(for: "upcoming") { self.loadMovies(with: $0) {
//                self.upcoming = $0
//                response()
//                } }
//        }
//    }
  
    
    public func loadMovies(with idList: [String], result: @escaping ([Movie])->Void ){
        var answer : [Movie] = []
        var goal = idList.count
        
        for id in idList {
            usleep(300) // 40 requests /s
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
                
                //wait for all movies to be loaded before returning the result
                goal -= 1
                if goal == 0 {
                    result(answer)
                }
                
            }.resume()
        }
    }
    
    public func loadIDs(for category: String, result: @escaping ([String]) -> Void) {
        
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
