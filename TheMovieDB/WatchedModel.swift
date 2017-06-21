//
//  WatchedModel.swift
//  TheMovieDB
//
//  Created by Eduardo Fornari on 21/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class WatchedModel {
    
    static func watchedMovie(withId id: String) -> Watched?{
        let userDefaults: UserDefaults = UserDefaults.standard
        var watchedMovies = [Watched]()
        if let data = userDefaults.object(forKey: "watchedMovies") {
            watchedMovies = (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Watched])!
            
            for watched in watchedMovies{
                if(watched.idFilme! == id){
                    return watched
                }
            }
            
        }
        return nil
    }
    
    static func watchedMovies() -> [Watched] {
        let userDefaults: UserDefaults = UserDefaults.standard
        var watchedMovies = [Watched]()
        
        if let data = userDefaults.object(forKey: "watchedMovies") {
            watchedMovies = (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Watched])!
        }else{
        }
        return watchedMovies
    }
    
    static func updateWatchedMovies(watchedMovies: [Watched]){
        let userDefaults: UserDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: watchedMovies)
        userDefaults.set(encodedData, forKey: "watchedMovies")
        userDefaults.synchronize()
    }
    
}
