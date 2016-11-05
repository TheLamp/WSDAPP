//
//  DetailsViewController.swift
//  SwiftRSSReader
//
//  Created by Prashant on 14/09/15. Updated by Gabe Zimbric on 2/26/16.
//  Copyright (c) 2015-2016 LampServ. All rights reserved.
//

import UIKit

class TestCalDetailsViewController: UIViewController, UIWebViewDelegate {
    
    // outlet - activity indicator
    @IBOutlet weak var spinner2: UIActivityIndicatorView!
    
    
    // outlet - web view
    @IBOutlet weak var mywebView2: UIWebView!
    
    
    // refresh button
    @IBAction func refreshButtonClicked(_ sender: UIBarButtonItem) {
        self.refreshWebView()
    }
    
    
    // link to browse (this value set by parent controller)
    var link: String?
    
    
    
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set webview delegate
        self.mywebView2.delegate = self

        // start spinner
        self.spinner2.startAnimating()
        
        // load url in webview
        if let fetchURL = URL(string: self.link! ) {
            let urlRequest = URLRequest(url: fetchURL)
            self.mywebView2.loadRequest(urlRequest)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // MARK: - Webview delegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // stop spinner
        self.spinner2.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        // stop spinner
        self.spinner2.stopAnimating()
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error loading events. Contact District for more info.")
    }
    
    
    
    
    // MARK: - Utility function
    
    // refresh webview
    func refreshWebView(){
        
        // start spinner
        self.spinner2.startAnimating()

        // reload webview
        self.mywebView2.reload()
        
    }
    
    // show alert with ok button
    fileprivate func showAlertMessage(alertTitle: String, alertMessage: String ) -> Void {
        
        // create alert controller
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert) as UIAlertController
        
        // create action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:
            { (action: UIAlertAction) -> Void in
                // you can add code here if needed
        })
        
        // add ok action
        alertCtrl.addAction(okAction)
        
        // present alert
        self.present(alertCtrl, animated: true, completion: { (void) -> Void in
            // you can add code here if needed
        })
    }
    

}
