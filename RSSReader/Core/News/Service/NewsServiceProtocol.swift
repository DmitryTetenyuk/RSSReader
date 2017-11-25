//
//  NewsServiceProtocol.swift
//  RSSReader
//
//  Created by Admin on 25.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RxSwift

protocol NewsServiceProtocol {
    func requestNewsFeed() -> Observable<[News]>
}
