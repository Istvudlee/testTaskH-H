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
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    
    // MARK: - public props
    var data: [NewsLineCellModel]?
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refresh
    }()
    
    // MARK: - closures
    var onRefreshCall: (() -> Void)?
    var onGetNextPost: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
    }
    
    // MARK: - private method
    private func configureUI() {
        addSubview(tableView)
        tableView.pinEdgesToSuperviewEdges()
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refreshAction() {
          onRefreshCall?()
    }
    
    // MARK: - public method
    func reloadTable() {
        tableView.reloadData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - TableViewDataSource, TableViewDelegate
extension NewsLineTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsLineTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? NewsLineTableViewCell else { return UITableViewCell()}
        
        if let data = self.data {
            cell.data = data[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data?[indexPath.row].sizes.fullHeight ?? 0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
            onGetNextPost?()
        }
    }
}

