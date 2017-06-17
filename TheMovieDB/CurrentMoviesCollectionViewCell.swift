//
//  CurrentMoviesCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class CurrentMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currentMovie: UIImageView!
    
    var movie : Movie!{
        didSet {
            currentMovie.image = self.movie.poster
        }
    }
    
  }
