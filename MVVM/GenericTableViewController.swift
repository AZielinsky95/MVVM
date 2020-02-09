//
//  ViewController.swift
//  MVVM
//
//  Created by Alejandro Zielinsky on 2020-02-08.
//  Copyright © 2020 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class StandardTableViewModel : TableViewModel {
 
    var data: [SectionViewModel]?
    
    func identifierForCells() -> [String : AnyClass] {
        return [StandardItemViewModel.cellId : StandardTableViewCell.self]
     }
}

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

struct SectionViewModel {
    
    var items : [ItemViewModel]
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func itemAt(_ row: Int) -> ItemViewModel {
        return items[row]
    }
}

protocol ItemViewModel {
    func cellIdentifier() -> String
}

protocol CellConfigurable {
    func setup(viewModel: ItemViewModel)
}

class GenericTableViewController: UITableViewController {
    
    enum TableViewState {
        case empty
        case networkError
        case loadingData
        case loaded
    }

    let model : TableViewModel
    
    private var state : TableViewState = .loadingData {
        didSet {
            self.onTableViewStateChanged()
        }
    }
    
    init(tableViewModel: TableViewModel,style: UITableView.Style) {
        self.model = tableViewModel
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.state = .loadingData
        if(model.hasPullToRefresh()) {
            let refreshControl = UIRefreshControl.init()
            refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
            self.refreshControl = refreshControl
        }
        updateRegisteredCellIdentifiers()
    }

    public func loadData() {
        print("TableView Loading")
        //Implement in subclass
        //This is where you should make a network call to get your data
        //And set your viewModels
    }
    
    @objc func onRefresh() {
        print("TableView Refreshing")
        if state == .loadingData {
            refreshControl?.endRefreshing()
            return
        }
        loadData()
    }
    
    func onDataLoaded() {
        print("TableView Finished Loading")
        refreshControl?.endRefreshing()
    }
    
    func onNetworkError() {
        print("TableView Nework Error")
    }
    
    func onEmptyData() {
        print("TableView Empty Data")
    }
    
    func onTableViewStateChanged() {
        switch state {
            case .empty:
                onEmptyData()
                break;
            case .loaded:
                onDataLoaded()
                break;
            case .loadingData:
                loadData()
                break;
            case .networkError:
                onNetworkError()
                break;
        }
    }
    
    public func updateRegisteredCellIdentifiers() {
        let cellIds = model.identifierForCells()
        for (keys, values) in cellIds {
           self.tableView.register(values, forCellReuseIdentifier: keys);
        }
   }
    
    func setState(_ newState: TableViewState) {
        self.state = newState
    }
}
//TableView Delegate Methods
extension GenericTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = model.sectionAt(indexPath.section)?.itemAt(indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(), for: indexPath)
        
            if let cell = cell as? CellConfigurable {
               cell.setup(viewModel: viewModel)
            }
            return cell
      }
      
      override func numberOfSections(in tableView: UITableView) -> Int {
          return self.model.numberOfSections()
      }
      
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.model.sectionAt(section)?.numberOfRows() ?? 0
      }
}

