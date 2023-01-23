//
//  CollectionTableVM.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation

class CollectionTableVM {
    //MARK: - Closures
    @Action var reloadCollectionView
    @Action var showEmptyCollection
    //MARK: - Properties
    var items: [CollectionItemProtocol] = []{
        didSet{
            if items.isEmpty {
                showEmptyCollection()
            }
            self.reloadCollectionView()
        }
    }
    
    var numberOfItems: Int {
        return items.count
    }
    func getItem(at indexPath: IndexPath) -> CollectionItemProtocol{
        return items[indexPath.row]
    }
    
    
}
