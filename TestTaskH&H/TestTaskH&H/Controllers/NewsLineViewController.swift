//
//  NewsLineViewController.swift
//  TestTaskH&H
//
//  Created by Анатолий Оруджев on 18.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit
import Kingfisher

class NewsLineViewController: UIViewController {
    
    // MARK: - private props
    private let getDataVK = GetData()
    private let newsLineTableView = NewsLineTableView()
    private let filters = "post"
    
    // MARK: - public props
    var token: String?
    
    var dataUser: [NewsLineCellModel]? {
        didSet {
            newsLineTableView.data = dataUser
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.white
        title = "Лента"
        configureUI()
        commonInit()
    }
    
    // MARK: - private method
    private func commonInit() {
        getDataVK.onSuccessGetData = { [weak self] data in
            self?.dataUser = data
            self?.newsLineTableView.reloadTable()
            self?.newsLineTableView.refreshControl.endRefreshing()
        }
        
        getDataVK.getData(filters, token: token ?? "")
        
        newsLineTableView.onRefreshCall = { [weak self] in
            self?.getDataVK.getData(self?.filters ?? "", token: self?.token ?? "")
        }
    }
    
    private func configureUI() {
        view.addSubview(newsLineTableView.prepareForAutoLayout())
        newsLineTableView.pinEdgesToSuperviewEdges()
    }
    
   
}
