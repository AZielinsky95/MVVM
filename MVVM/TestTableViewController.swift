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
        let item = StandardItemViewModel.init(model: model)
        let section = SectionViewModel.init(items: [item])
        self.model.data = [section]
        self.setState(.loaded)
    }
}
