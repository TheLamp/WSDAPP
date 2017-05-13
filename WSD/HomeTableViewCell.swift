//
//  HomeTableViewCell.swift
//  WSD
//
//  Created by Gabe Zimbric on 5/12/17.
//  Copyright © 2017 Gabe Zimbric. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.alpha = 0
        self.bodyLabel.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.titleLabel.alpha = 1
            self.bodyLabel.alpha = 1
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
