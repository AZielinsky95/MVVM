//
//  SectionViewModel.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import Foundation

struct SectionViewModel {
    
    var items : [ItemViewModel]
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func itemAt(_ row: Int) -> ItemViewModel {
        return items[row]
    }
}
