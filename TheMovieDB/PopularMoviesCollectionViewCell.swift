//
//  PopularMoviesCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
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
