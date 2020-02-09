//
//  StandardItemViewModel.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import Foundation

class StandardItemViewModel : ItemViewModel {

    static let cellId = "StandardItemViewModel"
    let title: String
    let subtitle: String?
    
    init(model: StandardModel) {
        title = model.title
        subtitle = model.subtitle
    }
    
    func cellIdentifier() -> String {
        return StandardItemViewModel.cellId
    }
}
