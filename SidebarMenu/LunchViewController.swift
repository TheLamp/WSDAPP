//
//  LunchController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15. Updated by Gabe Zimbric on 2/19/16.
//  Copyright (c) 2015-2016 AppCoda. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class LunchViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var webview2: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let url = URL(string: "https://thelampservices.com/lunch.pdf")
        let request = URLRequest(url: url!)
        
        webview2.loadRequest(request)
        
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
