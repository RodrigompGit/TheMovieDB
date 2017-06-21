//
//  Watched.swift
//  TheMovieDB
//
//  Created by Eduardo Fornari on 21/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class Watched: NSObject, NSCoding {
    var imageData: NSData!
    var idFilme: String!
    var date: Date!
    
    init(imageData: NSData, idFilme: String, date: Date) {
        self.imageData = imageData
        self.idFilme = idFilme
        self.date = date
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let imageData = aDecoder.decodeObject(forKey: "imageData") as! NSData
        let idFilme = aDecoder.decodeObject(forKey: "idFilme") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! Date
        self.init(
            imageData: imageData,
            idFilme: idFilme,
            date: date
        )
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageData, forKey: "imageData")
        aCoder.encode(idFilme, forKey: "idFilme")
        aCoder.encode(date, forKey: "date")
    }
    
}
