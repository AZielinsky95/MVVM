//
//  TableViewModel.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import Foundation

protocol TableViewModel: class {
    var data: [SectionViewModel]? { get set }

    func sectionAt(_ index: Int) -> SectionViewModel?
    func itemAt(_ indexPath: IndexPath) -> ItemViewModel?
    func numberOfSections() -> Int
    func hasPullToRefresh() -> Bool
    func identifierForCells() -> [String : AnyClass]
}

extension TableViewModel {
    
    func numberOfSections() -> Int {
        return data?.count ?? 0
    }
    
    func sectionAt(_ index: Int) -> SectionViewModel? {
        return data?[index]
    }
    
    func itemAt(_ indexPath: IndexPath) -> ItemViewModel? {
        return sectionAt(indexPath.section)?.itemAt(indexPath.row)
    }
    
    func hasPullToRefresh() -> Bool {
        return false
    }
}
