//
//  ViewController.swift
//  RSSReader
//
//  Created by Admin on 23.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import RxSwift

class NewsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView:UITableView?
    private var disposeBag = DisposeBag()
    private var newsViewModel:NewsViewModelProtocol?
    private var newsDataSource = NewsDataSource()
    private var overlayView:UIView?
    private var indicator:UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOverlay()
        initNewsList()
    }
    
    func setNewsViewModel(viewModel:NewsViewModelProtocol){
        newsViewModel = viewModel
        initObservers()
        newsViewModel?.getNewsFeed()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsDataSource.getNewsByIndex(indexPath.row)
        if(news != nil){
            newsViewModel?.newsChosen(news: news!)
        }
    }
    
    func initObservers(){
        //observe news
        newsViewModel?.getNewsObservable().asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (news) in
                self.newsDataSource.setNews(news: news)
                self.tableView?.reloadData()
            }).disposed(by: disposeBag)
        
        //observe progress
        newsViewModel?.getProgressObservable().asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (completed) in
                self.showActivityIndicator(isShown: completed)
            }).disposed(by: disposeBag)
        
        //observe error
        newsViewModel?.getErrorObservable().asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (completed) in
                //show error
            }).disposed(by: disposeBag)
    }
    
    func showActivityIndicator(isShown:Bool) {
        overlayView?.isHidden = !isShown
    }
    
    func initNewsList(){
        tableView?.dataSource = newsDataSource
        tableView?.delegate = self
        tableView?.estimatedRowHeight = 600
        tableView?.register(UINib(nibName: "NewsCellView", bundle: Bundle.main ), forCellReuseIdentifier: NewsCell.CELL_ID)
    }
    
    func initOverlay() {
        overlayView = UIView(frame: self.view.frame)
        overlayView?.center = self.view.center
        overlayView?.backgroundColor = UIColor.black
        overlayView?.alpha = 0.4
    
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator?.center = overlayView!.center
        overlayView?.addSubview(indicator!)
        
        indicator?.startAnimating()
        
        self.view.addSubview(overlayView!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }

}

