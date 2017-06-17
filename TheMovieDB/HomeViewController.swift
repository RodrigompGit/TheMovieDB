//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rodrigo Pacheco on 17/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var homeTableView: UITableView!
    let separatorColor = UIColor(colorLiteralRed: 0.0, green: 212.0, blue: 116.0, alpha: 0.40)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.delegate = self
        
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentMoviesTableViewCell")!
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    
    


}
