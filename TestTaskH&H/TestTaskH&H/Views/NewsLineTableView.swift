//
//  NewsLineTableView.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit

class NewsLineTableView: UIView {
    
    // MARK: - private props
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(NewsLineTableViewCell.self,
                       forCellReuseIdentifier: NewsLineTableViewCell.reuseIdentifier)
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    
    // MARK: - public props
    var data: [NewsLineCellModel]?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
    }
    
    // MARK: - private method
    private func configureUI() {
        addSubview(tableView)
        tableView.pinEdgesToSuperviewEdges()
    }
    // MARK: - publick method
    func reloadTable() {
        tableView.reloadData()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewsLineTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsLineTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? NewsLineTableViewCell else { return UITableViewCell()}
        
        if let data = data {
            cell.data = data[indexPath.row]
        }
        
        return cell
    }
}

