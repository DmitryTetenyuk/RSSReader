//
//  NetWork.swift
//  RSSReader
//
//  Created by Admin on 24.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyXML

class NewsServiceImplementation:NSObject, NewsServiceProtocol {
    static let sharedInstance = NewsServiceImplementation()
    private static let RSS_URL = "https://lenta.ru/rss"
    
    func requestNewsFeed() -> Observable<[News]>{
        return Observable.create { observer in
            var request = URLRequest(url: URL(string: NewsServiceImplementation.RSS_URL)!)
            request.httpMethod = "GET"
            let session = URLSession.shared
            session.dataTask(with: request) { [unowned self] (data, responce, error) in
                if (error != nil) {
                    observer.onError(error!)
                } else {
                    observer.onNext(self.parseXMLData(data!))
                }
                observer.on(.completed)
                }.resume()
            return Disposables.create()
        }
    }
    
    private func parseXMLData(_ XMLData:Data)->[News] {
        let xml = XML(data: XMLData)
        var parsedNews = [News]()
        for element in xml!["channel"]["item"] {
            if let description = element["description"].string,
                let title = element["title"].string,
                let date = element["pubDate"].string,
                let link = element["link"].string {
                parsedNews.append(News(description: description, title: title, date: date, webLink: link))
            } else {
                //err
            }
        }
       return parsedNews
    }
    
}
