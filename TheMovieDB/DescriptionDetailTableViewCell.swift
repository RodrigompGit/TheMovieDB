//
//  DescriptionDetailTableViewCell.swift
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class DescriptionDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionUILabel: UILabel!
    
    var movie: Movie! {
        didSet {
            descriptionUILabel.text = movie.overview
        }
    }
    
}
