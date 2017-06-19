//
//  potraitTableViewCell.swift
//  TheMovieDB
//
//  Created by Bruno Fulber Wide on 18/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class potraitTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    var movies: [Movie] = []

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.upcomingMoviesCollectionView.delegate = self
//        self.upcomingMoviesCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 0//movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "potraitCollectionViewCell", for: indexPath) as! potraitCollectionViewCell
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }

}
