//
//  CharacterDetailsViewController.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit
import SkeletonView

class CharacterDetailsViewController:  BaseViewController<CharacterDetailsVM> {

    let cellIdentifier = "CollectionTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitle("", for: .normal)
        setupTableView()
        viewModel.fetch()
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        
        viewModel.$titleText
            .assign(to: \.text!, for: titleLabel)
            .store(in: &cancellables)
        
        viewModel.$reloadTableView
            .sink(self) { _, strongSelf in
                strongSelf.tableView.reloadData()
            }.store(in: &cancellables)
        

        viewModel.$showEmptyTableView
            .sink(self) { _, strongSelf in
                strongSelf.tableView.showEmptyDataSet(title: "No Characters yet !", image: UIImage(named: "emptyCustomers")!, titleTextColor: UIColor(red: 7, green: 25, blue: 41)!)
            }.store(in: &cancellables)
        
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CharacterDetailsViewController: SkeletonTableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "DetailsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailsHeaderView")
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CollectionTableViewCell
        let info = viewModel.getData(at: indexPath)
        cell.configure(data: info.data , title: info.title)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailsHeaderView") as! DetailsHeaderView
        headerView.configureHeader(character: viewModel.character)
    return headerView
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }

}
