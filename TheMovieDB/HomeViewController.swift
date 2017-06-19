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
    
    let separatorColor = UIColor(colorLiteralRed: 0.0, green: 212.0, blue: 116.0, alpha: 0.40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
//        self.homeTableView.estimatedRowHeight = 234.5
//        self.homeTableView.rowHeight = UITableViewAutomaticDimension
        
        sleep(15)
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
            (cell as! CurrentMoviesTableViewCell).movies = model.nowPlaying
        case 1:
            cell =
                tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesTableViewCell") as! UpcomingMoviesTableViewCell
            (cell as! UpcomingMoviesTableViewCell).movies = model.upcoming
        default:
            cell =
                tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesTableViewCell") as! UpcomingMoviesTableViewCell
            (cell as! UpcomingMoviesTableViewCell).movies = model.popular
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
        let title = UILabel()
        
        title.text = homeTableView.dataSource?.tableView!(homeTableView, titleForHeaderInSection: section)
        
//        title.textAlignment = NSTextAlignmentCenter;
        
        //    title.backgroundColor = [UIColor blueColor];
        
        return title;
    }
    
    
    
    
    
    
}