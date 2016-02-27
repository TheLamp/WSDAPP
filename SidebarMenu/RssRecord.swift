//
//  RssRecord.swift
//  SwiftRSSReader
//
//  Created by Prashant on 14/09/15. Updated by Gabe Zimbric on 2/26/16.
//  Copyright (c) 2015-2016 LampServ. All rights reserved.
//

import Foundation


class RssRecord {

    var title: String
    var description: String
    var link: String
    //var pubDate: String
    
    init(){
        self.title = ""
        self.description = ""
        self.link = ""
        //self.pubDate = ""
    }
        
}