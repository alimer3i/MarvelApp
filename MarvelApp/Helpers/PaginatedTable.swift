//
//  PaginatedTable.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit

class PaginatedTable: UITableView {
//MARK: - Properties
    var isFetchInProgress = false
    var currentPage = 0
    var totalCount = 0
    var currentCount = 0
    var isRefreshEnabled: Bool = false {
        didSet {
            refreshControl = isRefreshEnabled ? refreshController: nil
        }
    }
    private var activityIndicator : UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        return spinner
    }()
    private let refreshController = UIRefreshControl()
//MARK: - Closures
    var executePagination: ((Int) -> Void)?
//MARK: - Lifecycle
    override func awakeFromNib() {
        self.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        prefetchDataSource = self
    }
//MARK: - Functions
    func executePagination(_ action: @escaping (Int) -> Void) {
        executePagination = action
    }
    func endLoading() {
        isFetchInProgress = false
        tableFooterView = nil
        guard refreshController.isRefreshing else {return}
        self.refreshController.endRefreshing()
    }
    @objc func refreshData() {
        load(isReset: true)
    }
    func load(isReset: Bool = false) {
        currentPage = isReset ? 0: (currentPage + 1)
        isFetchInProgress = true
        executePagination?(currentPage)
    }
}


//MARK: - UITableViewDataSourcePrefetching
extension PaginatedTable: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: {$0.row >= currentCount - 1}), !isFetchInProgress, !refreshController.isRefreshing, totalCount > currentCount else {return}
        load()
        tableFooterView = activityIndicator
    }
}
