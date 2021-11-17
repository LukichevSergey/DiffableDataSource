//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Сергей Лукичев on 17.11.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)

        tableView.rowHeight = 100
        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, Data>(tableView: tableView) { tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.configure(withItemModel: item)
        return cell
    }
    
    private var data: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        self.data = Data.fetchData()

        updateTable(from: data)
    }
    
    private func updateTable(from data: [Data]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Data>()
        snapshot.appendSections([.first])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    private func configureTableView() {
        tableView.delegate   = self
        tableView.dataSource = dataSource
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalTo(self.view)
        }
    }
}

extension ViewController: UITableViewDelegate {

}

