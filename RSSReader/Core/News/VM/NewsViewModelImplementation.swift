//
//  MainViewModel.swift
//  RSSReader
//
//  Created by Admin on 24.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RxSwift

class NewsViewModelImplementation: NSObject, NewsViewModelProtocol {
    
    //data
    private let newsVariable = Variable<[News]>([News]())
    private let errorVariable = Variable<String>("")
    private let progressVariable = Variable<Bool>(true)
    
    //common
    private var disposeBag = DisposeBag()
    private let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private var newsService:NewsServiceProtocol
    
    init(newsService:NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func getNewsObservable() -> Variable<[News]>{
        return newsVariable
    }
    
    func getProgressObservable() -> Variable<Bool>{
        return progressVariable
    }
    
    func getErrorObservable()-> Variable<String>{
        return errorVariable
    }
    
    func getNewsFeed() {
        progressVariable.value = true
        NewsServiceImplementation.sharedInstance.requestNewsFeed()
            .observeOn(concurrentScheduler)
            .subscribeOn(concurrentScheduler)
            .subscribe(onNext: { [unowned self] (news) in
                self.newsVariable.value = news
                self.progressVariable.value = false
            }, onError: { [unowned self] (error) in
                self.errorVariable.value = error.localizedDescription
                self.progressVariable.value = false
            }).disposed(by: disposeBag)
    }
    
    func newsChosen(news : News){
        UIApplication.shared.openURL(URL(string: news.newsWebLink!)!)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
}
