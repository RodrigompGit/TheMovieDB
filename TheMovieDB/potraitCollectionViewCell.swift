//
//  potraitCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Bruno Fulber Wide on 18/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class potraitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var alreadyWatchedIcon: UIImageView!
    
    var movie : Movie!{
        didSet {
            self.poster.image = movie.poster
        }
    }
    
    var didWatch : Bool? {
        didSet {
            if didWatch! {
                self.alreadyWatchedIcon.image =
                UIImage(contentsOfFile: "eyeWatched")
            }else{
                self.alreadyWatchedIcon.image =
                    UIImage(contentsOfFile: "eyeNotWatched")
            }
        }
    }
}
