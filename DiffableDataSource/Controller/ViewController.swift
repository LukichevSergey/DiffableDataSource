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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 100
        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, Data>(tableView: tableView) { tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.configure(withItemModel: item)
        return cell
    }
    
    private let data: [Data] = [
        Data(sign: "+", value: 100),
        Data(sign: "-", value: 200),
        Data(sign: "*", value: 300),
        Data(sign: "/", value: 400)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()

        updateTable(from: data)
    }
    
    private func updateTable(from data: [Data]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Data>()
        snapshot.appendSections([.first])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalTo(self.view)
        }
    }
    
    private func setTableViewDelegates() {
        tableView.delegate   = self
        tableView.dataSource = dataSource
    }
}

extension ViewController: UITableViewDelegate {

}

