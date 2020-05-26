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
        let filters = "post"
        getDataVK.getData(filters, token: token ?? "") { [weak self] data in
            self?.dataUser = data
            self?.newsLineTableView.reloadTable()
        }
    }
    private func configureUI() {
        view.addSubview(newsLineTableView.prepareForAutoLayout())
        newsLineTableView.pinEdgesToSuperviewEdges()
    }
}
