//
//  DataSource.swift
//  RSSReader
//
//  Created by Admin on 24.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyXML

class NewsDataSource: NSObject, UITableViewDataSource {
    
    var news = [News]()
    
    func setNews(news:[News]){
        self.news = news
    }
    
    func getNewsByIndex(_ index : Int) -> News?{
        if(index > news.count){
            return nil
        } else{
            return news[index]
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.CELL_ID, for: indexPath) as! NewsCell
        
        let newsForIndexPath = news[indexPath.row]
        
        cell.titleLabel?.text = newsForIndexPath.newsTitle
        cell.dateLabel?.text = newsForIndexPath.newsDate
        cell.descriptionLabel?.text = newsForIndexPath.newsDescription
        
        return cell
    }
    
   
    
}
