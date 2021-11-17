//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Сергей Лукичев on 17.11.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    static let reuseIdentifier = "cell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: ViewController.reuseIdentifier)
        tableView.rowHeight = 100
        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, Data>(tableView: tableView) { tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.reuseIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.configure(withItemModel: item)
        return cell
    }
    
    private var data: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        self.data = fetchData()

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
    private func fetchData() -> [Data] {
        var data: [Data] = []
        data.append(Data(sign: "+", value: 100))
        data.append(Data(sign: "-", value: 200))
        data.append(Data(sign: "/", value: 300))
        data.append(Data(sign: "*", value: 400))
        return data
    }
}

