//
//  TableViewCell.swift
//  DiffableDataSource
//
//  Created by Сергей Лукичев on 17.11.2021.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    lazy var sign: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 35)
        return label
    }()
    
    lazy var value: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 35)
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(value)
        value.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).inset(16)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addSubview(sign)
        sign.snp.makeConstraints { make in
            make.right.equalTo(value.snp.left).inset(-16)
            make.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(withItemModel model: Data) {
        self.sign.text = model.sign
        self.value.text = "\(model.value)"
    }

}