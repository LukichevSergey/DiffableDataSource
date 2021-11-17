//
//  Data.swift
//  DiffableDataSource
//
//  Created by Сергей Лукичев on 17.11.2021.
//

import Foundation

struct Data: Hashable {
    let sign:  String
    let value: Int
    
    static func fetchData() -> [Data] {
        var data: [Data] = []
        data.append(Data(sign: "+", value: 100))
        data.append(Data(sign: "-", value: 200))
        data.append(Data(sign: "/", value: 300))
        data.append(Data(sign: "*", value: 400))
        return data
    }
}
