//
//  Actor.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

struct Actor {

    var name : String
    var character : String
    var profile : UIImage?
    var aux : Dictionary<String, AnyObject>!
    
    init(with data: Dictionary<String, AnyObject>) {
        name = data["name"] as! String
        character = data["character"] as! String
        
        print("A")
        aux = data
    }
    
    static public func loadImage(at path: String?, resolution: String = "original") -> UIImage? {
        
        if path == nil { return nil }
        
        let url = URL(string: "https://image.tmdb.org/t/p/\(resolution)" + path! )
        
        if let data = try? Data(contentsOf: url!) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
}
