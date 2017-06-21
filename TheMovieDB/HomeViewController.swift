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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 7.0/255.0, green: 28.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        tabBarController?.tabBar.tintColor = UIColor.init(red: 0.0/255.0, green: 212.0/255.0, blue: 116.0/255.0, alpha: 1.0)
        tabBarController?.tabBar.barTintColor = UIColor.white
        
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self

        //wait for model to be loaded to reload tableview
        DispatchQueue.global().async {
            self.model.loadNowPlaying {
                self.model.loadUpcoming {
                    DispatchQueue.main.async { self.homeTableView.reloadData() }
                }
            }
        }
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
            DispatchQueue.global().async {
                self.model.loadPopular {
                    (cell as! PopularMoviesTableViewCell).movies = self.model.popular
                }
            }
        }
        
        cell.selectionStyle = .none
        
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
        let height = CGFloat(18)
        
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.horizontal
        //        stackView.backgroundColor = UIColor.init(red: 7.0/255.0, green: 28.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        stackView.spacing = 10
        stackView.distribution = UIStackViewDistribution.fill
        stackView.widthAnchor.constraint(equalToConstant: self.homeTableView.frame.size.width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        let imageView = UIImageView(image: UIImage(named: "sectionMark"))
        imageView.widthAnchor.constraint(equalToConstant: (imageView.image?.size.width)!).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (imageView.image?.size.height)!).isActive = true
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: height))
        title.text = tableView.dataSource?.tableView!(tableView, titleForHeaderInSection: section)
        title.textColor = UIColor.white
        title.textAlignment = .left
        title.widthAnchor.constraint(equalToConstant: title.frame.size.width).isActive = true
        title.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(title)
        
        return stackView;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            if let destinationViewController = segue.destination as? DetailViewController {
                
                var movie = sender as? Movie
                destinationViewController.movie = movie

            }
        }
        
        
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
            return 2446
        }
    }
}
