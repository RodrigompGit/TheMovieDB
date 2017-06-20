//
//  CurrentMoviesTableViewCell.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 16/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class CurrentMoviesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var currentMoviesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var movies: [Movie] = [] {
        didSet{
            DispatchQueue.main.async { self.currentMoviesCollectionView.reloadData() }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.currentMoviesCollectionView.delegate = self
        self.currentMoviesCollectionView.dataSource = self
        
        self.currentMoviesCollectionView.showsVerticalScrollIndicator = false
        self.currentMoviesCollectionView.showsHorizontalScrollIndicator = false
        
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPage = 0
        self.pageControl.updateCurrentPageDisplay()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.movies.count != 0 {
            let firstFourElements = self.movies[0..<4]
            return firstFourElements.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentMoviesCollectionViewCell", for: indexPath) as! CurrentMoviesCollectionViewCell
        
        if indexPath.row < self.pageControl.numberOfPages {
            cell.movie = self.movies[indexPath.row]
        }
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        parentViewController?.performSegue(withIdentifier: "showDetailsMovies", sender: movies[indexPath.row])
//    }

}
