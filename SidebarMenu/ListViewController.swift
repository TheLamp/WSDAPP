//
//  ListViewController.swift
//  SwiftRSSReader
//
//  Created by Prashant on 14/09/15. Updated by Gabe Zimbric on 2/26/16.
//  Copyright (c) 2015-2016 LampServ. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    
    // outlet - table view
    @IBOutlet weak var myTableView: UITableView!
    
    
    // outlet - barbutton
    @IBOutlet weak var menuButton: UIBarButtonItem!

    // slide to refresh
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // xml parser
    var myParser: XMLParser = XMLParser()
    
    // rss records
    var rssRecordList : [RssRecord] = [RssRecord]()
    var rssRecord : RssRecord?
    var isTagFound = [ "item": false , "title":false, "pubDate": false ,"link":false]
    
    
    
    // MARK - View functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        // pull to refresh
        refreshControl.addTarget(self, action: #selector(ListViewController.uiRefreshControlAction), for: UIControlEvents.valueChanged)
        self.myTableView.addSubview(refreshControl);
        
        
        // set tableview delegate
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
    }
    
    func uiRefreshControlAction() {
        self.refreshControl.beginRefreshing()
        rssRecordList.removeAll()
        if let rssURL = URL(string: RSS_FEED_URL) {
            
            // fetch rss content from url
            self.myParser = XMLParser(contentsOf: rssURL)!
            
            // set parser delegate
            self.myParser.delegate = self
            self.myParser.shouldResolveExternalEntities = false
            
            // start parsing
            self.myParser.parse()
        }
        
        self.myTableView.reloadData()
        self.refreshControl.endRefreshing()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // load Rss data and parse
        if self.rssRecordList.isEmpty {
            self.loadRSSData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Table view dataSource and Delegate
    
    // return number of section within a table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // return row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // return how may records in a table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssRecordList.count
    }
    
    // return cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // collect reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "rssCell", for: indexPath)
        
        // find record for current cell
        let thisRecord : RssRecord  = self.rssRecordList[(indexPath as NSIndexPath).row]
        
        // set value for main title and detail tect
        cell.textLabel?.text = thisRecord.title
        //cell.detailTextLabel?.text = thisRecord.description
        
        // return cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueShowDetails", sender: self)
    }
    
    
    
    
    // MARK: - NSXML Parse delegate function
    
    // start parsing document
    func parserDidStartDocument(_ parser: XMLParser) {
        // start parsing
    }
    
    // element start detected
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item" {
            self.isTagFound["item"] = true
            self.rssRecord = RssRecord()
            
        }else if elementName == "title" {
            self.isTagFound["title"] = true
            
        }else if elementName == "link" {
            self.isTagFound["link"] = true
            
        }else if elementName == "pubDate" {
            self.isTagFound["pubDate"] = true
        }
        
    }
    
    // characters received for some element
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isTagFound["title"] == true {
            self.rssRecord?.title += string
            
        }else if isTagFound["link"] == true {
            self.rssRecord?.link += string
            
            //}else if isTagFound["pubDate"] == true {
            //    self.rssRecord?.pubDate += string
        }
        
    }
    
    // element end detected
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            self.isTagFound["item"] = false
            self.rssRecordList.append(self.rssRecord!)
            
        }else if elementName == "title" {
            self.isTagFound["title"] = false
            
        }else if elementName == "link" {
            self.isTagFound["link"] = false
            
        }else if elementName == "pubDate" {
            self.isTagFound["pubDate"] = false
        }
    }
    
    // end parsing document
    func parserDidEndDocument(_ parser: XMLParser) {
        
        //reload table view
        self.myTableView.reloadData()
        
    }
    
    // if any error detected while parsing.
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading feed. Contact District for more info.")
    }
    
    
    
    
    // MARK: - Utility functions
    
    // load rss and parse it
    fileprivate func loadRSSData(){
        
        if let rssURL = URL(string: RSS_FEED_URL) {
            
            
            // fetch rss content from url
            self.myParser = XMLParser(contentsOf: rssURL)!
            
            // set parser delegate
            self.myParser.delegate = self
            self.myParser.shouldResolveExternalEntities = false
            
            // start parsing
            self.myParser.parse()
        }
        
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
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segueShowDetails" {
            
            // find index path for selected row
            let selectedIndexPath : [IndexPath] = self.myTableView.indexPathsForSelectedRows!
            
            // deselect the selected row
            self.myTableView.deselectRow(at: selectedIndexPath[0], animated: true)
            
            // create destination view controller
            let destVc = segue.destination as! DetailsViewController
            
            // set title for next screen
            destVc.navigationItem.title = self.rssRecordList[(selectedIndexPath[0] as NSIndexPath).row].title
            
            // set link value for destination view controller
            destVc.link = self.rssRecordList[(selectedIndexPath[0] as NSIndexPath).row].link
            
        }
        
    }
    
}
