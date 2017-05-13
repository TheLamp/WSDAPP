//
//  HomeTableViewController.swift
//  WSD
//
//  Created by Gabe Zimbric on 5/12/17.
//  Copyright © 2017 Gabe Zimbric. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var homePosts = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate in viewDidLoad
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Variable cell size
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 250
        
        loadData()
        
        // Add refreshControl to ViewController
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Loads post database from Firebase
    func loadData() {
        FIRDatabase.database().reference().child("posts").observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let postsDictionary = snapshot.value as? [String: AnyObject] {
                for post in postsDictionary {
                    self.homePosts.add(post.value)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    // Slide to Refresh
    func refresh(_ refreshControl: UIRefreshControl) {
        homePosts.removeAllObjects()
        FIRDatabase.database().reference().child("posts").observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let postsDictionary = snapshot.value as? [String: AnyObject] {
                for post in postsDictionary {
                    self.homePosts.add(post.value)
                }
                self.tableView.reloadData()
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    // Do your job, when done:
                    refreshControl.endRefreshing()
                }
            }
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Determines # of cells based on number of posts in database
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.homePosts.count
    }
    
    // Displays posts in postsTableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeTableViewCell
        // Configure the cell...
        let post = self.homePosts[indexPath.row] as! [String: AnyObject]
        cell.titleLabel.text = post["title"] as? String
        cell.bodyLabel.text = post["body"] as? String
        return cell
    }
}
