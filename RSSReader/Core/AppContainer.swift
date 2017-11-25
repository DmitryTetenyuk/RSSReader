//
//  AppContainer.swift
//  RSSReader
//
//  Created by Admin on 25.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation


class AppContainer: NSObject {
    
    private var newsService:NewsServiceProtocol?
    private var newsViewModel:NewsViewModelProtocol?
    
    
    override init() {
        super.init()
        initService()
        initViewModel()
    }
    
    private func initService(){
        newsService = NewsServiceImplementation()
    }
    
    private func initViewModel(){
        newsViewModel = NewsViewModelImplementation(newsService: newsService!)
    }
    
    func getNewsService() -> NewsServiceProtocol {
        return newsService!
    }
    
    func getNewsViewModel() -> NewsViewModelProtocol {
        return newsViewModel!
    }
}
