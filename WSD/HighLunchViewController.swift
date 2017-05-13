//
//  LunchViewController.swift
//  WSD
//
//  Created by Gabe Zimbric on 5/13/17.
//  Copyright © 2017 Gabe Zimbric. All rights reserved.
//

import UIKit
import Firebase

class HighLunchViewController: UIViewController {
    @IBOutlet weak var lunchLine1: UILabel!
    @IBOutlet weak var lunchLine2: UILabel!
    @IBOutlet weak var lunchLine3: UILabel!
    @IBOutlet weak var lunchLine4: UILabel!
    @IBOutlet weak var lunchLine5: UILabel!
    @IBOutlet weak var lunchLine6: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Finds today's date
        let formatter : DateFormatter = DateFormatter();
        formatter.dateFormat = "dd-MM-yy";
        let date : String = formatter.string(from: NSDate.init(timeIntervalSinceNow: 0) as Date);
        FIRDatabase.database().reference().child("lunchMenu").child("highSchool").child(date).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.lunchLine1.text = dictionary["lineOne"] as? String
                self.lunchLine2.text = dictionary["lineTwo"] as? String
                self.lunchLine3.text = dictionary["lineThree"] as? String
                self.lunchLine4.text = dictionary["lineFour"] as? String
                self.lunchLine5.text = dictionary["lineFive"] as? String
                self.lunchLine6.text = dictionary["lineSix"] as? String
            }
            self.lunchLine1.alpha = 0
            self.lunchLine2.alpha = 0
            self.lunchLine3.alpha = 0
            self.lunchLine4.alpha = 0
            self.lunchLine5.alpha = 0
            self.lunchLine6.alpha = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.lunchLine1.alpha = 1
                self.lunchLine2.alpha = 1
                self.lunchLine3.alpha = 1
                self.lunchLine4.alpha = 1
                self.lunchLine5.alpha = 1
                self.lunchLine6.alpha = 1
            })
        })
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
