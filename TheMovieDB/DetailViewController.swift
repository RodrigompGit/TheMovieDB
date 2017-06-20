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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 200;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
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
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DescriptionDetailTableViewCell", for: indexPath) as! DescriptionDetailTableViewCell
            return cell
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoDetailTableViewCell", for: indexPath) as! VideoDetailTableViewCell
            return cell
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CastDetailTableViewCell", for: indexPath) as! CastDetailTableViewCell
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "WatchDetailTableViewCell", for: indexPath) as! WatchDetailTableViewCell
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
        let title = UILabel()
        
        title.text = self.tableView.dataSource?.tableView!(self.tableView, titleForHeaderInSection: section)
        title.textColor = UIColor.white
        title.backgroundColor = UIColor.init(red: 7.0/255.0, green: 28.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        return title;
    }


}

