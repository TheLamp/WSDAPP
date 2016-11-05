//
//  DetailsViewController.swift
//  SwiftRSSReader
//
//  Created by Prashant on 14/09/15. Updated by Gabe Zimbric on 2/26/16.
//  Copyright (c) 2015-2016 LampServ. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIWebViewDelegate {

    
    // outlet - activity indicator
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    // outlet - web view
    @IBOutlet weak var myWebView: UIWebView!
    
    
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
        self.myWebView.delegate = self

        // start spinner
        self.spinner.startAnimating()
        
        // load url in webview
        if let fetchURL = URL(string: self.link! ) {
            let urlRequest = URLRequest(url: fetchURL)
            self.myWebView.loadRequest(urlRequest)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // MARK: - Webview delegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // stop spinner
        self.spinner.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        // stop spinner
        self.spinner.stopAnimating()
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading url.")
    }
    
    
    
    
    // MARK: - Utility function
    
    // refresh webview
    func refreshWebView(){
        
        // start spinner
        self.spinner.startAnimating()

        // reload webview
        self.myWebView.reload()
        
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
