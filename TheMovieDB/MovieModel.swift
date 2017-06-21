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
    
    let api_key = "7ee9b443aa187e3537589cc0b8a80a8b"
    
    var nowPlaying: [Movie] = []
    var upcoming: [Movie] = []
    var popular: [Movie] = []
    
    func loadNowPlaying(completion: @escaping (Void) -> Void) {
        self.loadIDs(for: "now_playing") {
            self.loadMovies(with: $0) {
                self.nowPlaying = $0
                completion()
            }
        }
    }
    
    func loadUpcoming(completion: @escaping (Void) -> Void) {
        self.loadIDs(for: "upcoming") {
            self.loadMovies(with: $0) {
                self.upcoming = $0
                completion()
            }
        }
    }
    
    func loadPopular(completion: @escaping (Void) -> Void) {
        self.loadIDs(for: "popular") {
            self.loadMovies(with: $0) {
                self.popular = $0
                completion()
            }
        }
    }
    
    public func loadMovies(with idList: [String], result: @escaping ([Movie])->Void ){
        var answer : [Movie] = []
        var goal = idList.count
        
        for id in idList {
            let url =
            URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(api_key)&language=en-US&append_to_response=videos")!
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    let data = jsonData as? Dictionary<String, AnyObject>
                    if data == nil{
                        //print("Nuloooooooooo")
                    }
                    else {
                        if (data?["id"] as? Int) != nil{
                            answer.append( Movie(with: data!) )
                        }
                        else{
                            print("NULOOOOOOOOOOOOO")
                        }
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
        
        var verify = false
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dict = jsonData as? Dictionary<String, AnyObject> {
                    
                    var dictArray = dict["results"] as? [Dictionary<String, AnyObject>]
                    
                    if dictArray == nil{
                        print("NULOOOOOOOOOOOOO2222")
                        
                        
                        self.loadIDs(for: category, result: result)
                        
//                        while(dictArray == nil && verify == false){
//                            let request2 = URLRequest(url: url)
//                            
//                            let session2 = URLSession.shared
//                            
//                            session2.dataTask(with: request2) { (data2, response2, error) in
//                                do {
//                                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
//                                    
//                                    if let dict = jsonData as? Dictionary<String, AnyObject> {
//                                        
//                                        dictArray = dict["results"] as? [Dictionary<String, AnyObject>]
//                                        
//                                        
//                                        if dictArray == nil{
//                                            
//                                        }else{
//                                            verify = true
//                                        }
//                                }
//                                }catch let error {
//                                    print(error)
//                                }
//                            }.resume()
//                        }
//                            var idList: [String] = []
//                            
//                            for movie in dictArray! {
//                                idList.append( (movie["id"] as! Int).description )
//                            }
//                            
//                            result(idList)

                            }else{
                    

                    
                    var idList: [String] = []
                    
                    for movie in dictArray! {
                        idList.append( (movie["id"] as! Int).description )
                    }
                    
                    result(idList)
                    }
                    
                }else{
                    print("couldn't convert")
                }
                
            } catch let error {
                print(error)
            }
                }.resume()
    }
}
