//
//  HeaderDetailTableViewCell.swift
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class HeaderDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingUILabel: UILabel!
    @IBOutlet weak var titleUILabel: UILabel!
    @IBOutlet weak var ratingBarUILabel: NSLayoutConstraint!
    @IBOutlet weak var backdropUIImageView: UIImageView!
    
    @IBOutlet weak var runtimeUILabel: UILabel!
    @IBOutlet weak var genresUILabel: UILabel!
    @IBOutlet weak var posterUIImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            titleUILabel.text = movie.title
            posterUIImageView.image = movie.poster
            backdropUIImageView.image = movie.backdrop
            ratingUILabel.text = "\(movie.rating!*10)%"
            if let rating = movie.rating {
                ratingBarUILabel.constant = CGFloat(rating * 10)
            }
            
            var genres = ""
            for genre in movie.genres! {
                if(movie.genres!.index(of: genre) == movie.genres!.count){
                    genres += genres
                }
                else{
                    genres += "\(genre), "
                }
            }
            genresUILabel.text = genres
            
//            runtimeUILabel.text = "\(movie.runtime!/60)h \(movie.runtime! % 60)m"
        }
    }
}
