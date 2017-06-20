//
//  WatchedTableViewCell.swift
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 20/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class WatchedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var watchedMoviesCollectionView: UICollectionView!
    var movies: [String] = ["a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.watchedMoviesCollectionView.delegate = self
        self.watchedMoviesCollectionView.dataSource = self
        
        self.watchedMoviesCollectionView.showsVerticalScrollIndicator = false
        self.watchedMoviesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchedCollectionViewCell", for: indexPath) as! WatchedCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = self.watchedMoviesCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        
        return view;
    }
    
}
