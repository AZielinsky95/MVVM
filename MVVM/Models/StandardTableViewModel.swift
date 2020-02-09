//
//  StandardTableViewMode.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class StandardTableViewModel: TableViewModel {
    
    var data: [SectionViewModel]?
       
    func identifierForCells() -> [String : AnyClass] {
        return [StandardItemViewModel.cellId : StandardTableViewCell.self]
    }
}
