//
//  News.swift
//  RSSReader
//
//  Created by Admin on 23.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class News : NSObject {
    public var newsDescription:String?
    public var newsTitle:String?
    public var newsDate:String?
    public var newsWebLink:String?
    
    init(description:String, title:String, date:String, webLink:String) {
        newsDescription = description
        newsTitle = title
        newsDate = date
        newsWebLink = webLink
    }
}
