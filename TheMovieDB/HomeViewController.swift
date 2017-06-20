//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 17/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let model = MovieModel.shared
    
    @IBOutlet weak var homeTableView: UITableView!
    
    //let separatorColor = UIColor(red: 0.0, green: 212.0, blue: 116.0, alpha: 0.40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
        //self.homeTableView.separatorColor = self.separatorColor
        
        
//        while true {
//            if MovieModel.shared.didLoad { break }
//        }
        
        MovieModel.shared.loadIDs(for: "now_playing") { (categories) in
            MovieModel.shared.loadMovies(with: categories, result: { (movies) in
                MovieModel.shared.nowPlaying = movies
                
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            })
        }
        
        MovieModel.shared.loadIDs(for: "popular") { (categories) in
            MovieModel.shared.loadMovies(with: categories, result: { (movies) in
                MovieModel.shared.popular = movies
                
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            })
        }
        
        
        MovieModel.shared.loadIDs(for: "upcoming") { (categories) in
            MovieModel.shared.loadMovies(with: categories, result: { (movies) in
                MovieModel.shared.upcoming = movies
                
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            })
        }
        
        print("endddddd")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell =
                tableView.dequeueReusableCell(withIdentifier: "CurrentMoviesTableViewCell") as! CurrentMoviesTableViewCell
            (cell as! CurrentMoviesTableViewCell).movies = self.model.nowPlaying
        case 1:
            cell =
                tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesTableViewCell") as! UpcomingMoviesTableViewCell
            (cell as! UpcomingMoviesTableViewCell).movies = model.upcoming
        default:
            cell =
                tableView.dequeueReusableCell(withIdentifier: "PopularMoviesTableViewCell") as! PopularMoviesTableViewCell
            (cell as! PopularMoviesTableViewCell).movies = model.popular
            
            cell.frame.size.height = 700
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "Upcoming"
            break
        case 2:
            title = "Popular"
            break
        default:
            break
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       // var view = UIView()
        let title = UILabel()
        
        //let viewBackGround = UIImageView()
        //viewBackGround.image = UIImage(contentsOfFile: "Scream")
        
        title.text = homeTableView.dataSource?.tableView!(homeTableView, titleForHeaderInSection: section)
        
        title.backgroundColor = UIColor.init(red: 7.0/255.0, green: 28.0/255.0, blue: 36.0/255.0, alpha: 1.0)

        title.textColor = UIColor.white

        //view = title
        //view = viewBackGround
    
        return title;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "CurrentMoviesTableViewCell") as! CurrentMoviesTableViewCell
            return cell.frame.size.height
        case 1:
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesTableViewCell") as! UpcomingMoviesTableViewCell
            return cell.frame.size.height
        default:
            let lines = CGFloat( model.popular.count % 2 == 0 ? model.popular.count/2 : model.popular.count + 1)
            var height = lines * 234.5
            height += (lines-1) * 11
            return 2446
        }
    }
}
