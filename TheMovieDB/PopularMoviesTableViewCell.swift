//
//  PopularMoviesTableViewCell.swift
//  TheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import Foundation

import UIKit

class PopularMoviesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    
    var movies: [Movie] = [] {
        didSet{
            DispatchQueue.main.async { self.upcomingMoviesCollectionView.reloadData() }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.upcomingMoviesCollectionView.delegate = self
        self.upcomingMoviesCollectionView.dataSource = self
        
        self.upcomingMoviesCollectionView.showsVerticalScrollIndicator = false
        self.upcomingMoviesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.parentViewController?.performSegue(withIdentifier: "DetailViewController", sender: movies[indexPath.row])
    }
    
}
