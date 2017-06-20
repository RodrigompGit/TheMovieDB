//
//  CastDetailTableViewCell.swift
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class CastDetailTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movie: Movie! {
        didSet {
            cast = movie.actors!
        }
    }
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    var cast: [Actor] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.castCollectionView.delegate = self
        self.castCollectionView.dataSource = self
        
        self.castCollectionView.showsVerticalScrollIndicator = false
        self.castCollectionView.showsHorizontalScrollIndicator = false
        
        // print("space = \(upcomingMoviesCollectionView.spa)")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        cell.actor = cast[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
