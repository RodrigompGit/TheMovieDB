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
    
    init(with data: Dictionary<String, AnyObject>) {
        
        name = data["name"] as! String
        character = data["character"] as! String
        
    }
    
}
