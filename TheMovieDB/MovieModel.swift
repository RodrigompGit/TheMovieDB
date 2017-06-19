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
        self.loadNowPlaying(result: { self.nowPlaying = $0 })
        self.loadUpcoming(result: { self.upcoming = $0 })
        self.loadPopular(result: {
            self.popular = $0
            //load all playlists and send response when the last one is laoded
            response()
        })
    }
    
    
    
    private func loadUpcoming(result: @escaping ([Movie]) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(self.api_key)&language=en-US&page=1")!
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dictArray = jsonData as? Dictionary<String, AnyObject> {
                    
                    let dictArray = dictArray["results"] as! [Dictionary<String, AnyObject>]
                    
                    
                    var movieList: [Movie] = []
                    
                    for movieData in dictArray {
                        movieList.append( Movie(with: movieData) )
                    }
                    
                    result(movieList)
                    
                }else{
                    print("couldn't convert")
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func loadNowPlaying(result: @escaping ([Movie]) -> Void){
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(self.api_key)&language=en-US&page=1")!
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dictArray = jsonData as? Dictionary<String, AnyObject> {
                    
                    let dictArray = dictArray["results"] as! [Dictionary<String, AnyObject>]

                    
                    var movieList: [Movie] = []
                    
                    for movieData in dictArray {
                        movieList.append( Movie(with: movieData) )
                    }
                    
                    result(movieList)
                    
                }else{
                    print("couldn't convert")
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func loadPopular(result: @escaping ([Movie]) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(self.api_key)&language=en-US&page=1")!
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dictArray = jsonData as? Dictionary<String, AnyObject> {
                    
                    let dictArray = dictArray["results"] as! [Dictionary<String, AnyObject>]
                    
                    
                    var movieList: [Movie] = []
                    
                    for movieData in dictArray {
                        movieList.append( Movie(with: movieData) )
                    }
                    
                    result(movieList)
                    
                }else{
                    print("couldn't convert")
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
