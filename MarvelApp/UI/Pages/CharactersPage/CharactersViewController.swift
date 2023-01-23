//
//  CharactersViewController.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit
import SkeletonView

class CharactersViewController:  BaseViewController<CharactersVM> {
    
    let cellIdentifier = "CharacterTableViewCell"
    
    
    @IBOutlet weak var tableView: PaginatedTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetch()
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
        viewModel.$reloadTableView
            .sink(self) { _, strongSelf in
                strongSelf.tableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$updatePagination
            .sink(self) { data, strongSelf in
                strongSelf.tableView.totalCount = data.totalCount
                strongSelf.tableView.currentCount = data.currentCount
            }.store(in: &cancellables)
        
        viewModel.$endLoading
            .sink(self) { _, strongSelf in
                strongSelf.tableView.endLoading()
            }.store(in: &cancellables)
        
        viewModel.$showEmptyTableView
            .sink(self) { _, strongSelf in
                strongSelf.tableView.showEmptyDataSet(title: "No Characters yet !", image: UIImage(named: "emptyCustomers")!, titleTextColor: UIColor(red: 7, green: 25, blue: 41)!)
            }.store(in: &cancellables)
        
        viewModel.$navigateToDetails
            .sink(self) { item, strongSelf in
                let vc = CharacterDetailsViewController.pushVC(mainView: strongSelf)
                vc.viewModel.character = item
            }.store(in: &cancellables)
    }
}

extension CharactersViewController: SkeletonTableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        //        tableView.emptyDataSetSource = self
        //        tableView.emptyDataSetDelegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.executePagination { [weak self] page in
            self?.viewModel.fetch(page: page)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.didSelectRow(at: indexPath)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CharacterTableViewCell
        cell.configureCell(character: self.viewModel.getItem(at: indexPath))
        return cell
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
}
