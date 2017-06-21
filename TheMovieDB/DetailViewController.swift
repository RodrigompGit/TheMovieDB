//
//  DetailController
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 200;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        
        if(movie != nil){
            movie?.loadActors() { self.movie?.actors = $0 }
        }
//        self.navigationController?.toolbar.isTranslucent = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderDetailTableViewCell", for: indexPath) as! HeaderDetailTableViewCell
            cell.movie = self.movie
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DescriptionDetailTableViewCell", for: indexPath) as! DescriptionDetailTableViewCell
            cell.movie = self.movie
            return cell
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoDetailTableViewCell", for: indexPath) as! VideoDetailTableViewCell
            cell.movie = self.movie
            return cell
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CastDetailTableViewCell", for: indexPath) as! CastDetailTableViewCell
            cell.movie = self.movie
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "WatchDetailTableViewCell", for: indexPath) as! WatchDetailTableViewCell
            cell.movie = self.movie
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "Overview"
            break
        case 2:
            title = "Videos"
            break
        case 3:
            title = "Top Billed Cast"
            break
        case 4:
            title = "Your Picture"
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
        stackView.widthAnchor.constraint(equalToConstant: self.tableView.frame.size.width).isActive = true
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


}

