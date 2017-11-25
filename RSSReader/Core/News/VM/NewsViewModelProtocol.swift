//
//  NewsViewModelProtocol.swift
//  RSSReader
//
//  Created by Admin on 25.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RxSwift


protocol NewsViewModelProtocol {
    
    func getNewsObservable() -> Variable<[News]>
    func getProgressObservable() -> Variable<Bool>
    func getErrorObservable()-> Variable<String>
    func getNewsFeed()
    func newsChosen(news : News)
}
