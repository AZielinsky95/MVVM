//
//  StandardTableViewCell.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class StandardTableViewCell: UITableViewCell, CellConfigurable {

    func setup(viewModel: ItemViewModel) {
        guard let model = viewModel as? StandardItemViewModel else { return }
        self.textLabel?.text = model.title
        self.detailTextLabel?.text = model.subtitle
    }
}
