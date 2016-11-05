//
//  AboutViewController.swift
//  WSDAPP
//
//  Created by Gabe Zimbric on 2/20/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Foundation

class AboutViewController: UITableViewController {
    
    @IBOutlet weak var drawer: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            drawer.target = self.revealViewController()
            drawer.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
