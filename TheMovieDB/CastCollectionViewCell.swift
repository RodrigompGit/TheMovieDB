//
//  CastCollectionViewCell.swift
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var profileUIImageview: UIImageView!
    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var characterUILabel: UILabel!
    
    var actor: Actor! {
        didSet {
            nameUILabel.text = actor.name
            characterUILabel.text = actor.character
            profileUIImageview.image = actor.profile
            actor.profile = Actor.loadImage(at: actor.aux["profile_path"] as? String, resolution: "w342")
            if actor.profile != nil{
                profileUIImageview.image = actor.profile
            }
        }
    }
    
}
