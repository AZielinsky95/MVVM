//
//  TestTableViewController.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class TestTableViewController: GenericTableViewController {

    override func loadData() {
        super.loadData()
        let model = StandardModel.init(title: "Testing", subtitle: nil)
        let model2 = StandardModel.init(title: "Testing Again", subtitle: nil)
        let item = StandardItemViewModel.init(model: model)
        let item2 = StandardItemViewModel.init(model: model2)
        let section = SectionViewModel.init(items: [item, item2])
        self.model.data = [section]
        self.setState(.loaded)
    }
}
