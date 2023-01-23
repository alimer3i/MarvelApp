//
//  LandingViewControllerPresenter.swift
//  MarvelApp
//
//  Created by Ali Merhie on 10/6/20.
//  Copyright © 2020 Ali Merhie. All rights reserved.
//

import Foundation
protocol LandingViewControllerDelegate: AnyObject {
    func currentPageChanged(index: Int)
    func updateText(title: String)
    func reloadCollectionData()
    func didSelectCollectionRow(indexPath: IndexPath)
}

class LandingViewControllerPresenter {
    private weak var delegate: LandingViewControllerDelegate!
    
    var currentPage = 0 {
        didSet {
            //if currentPage != oldValue && currentPage < items.count{
            if currentPage != oldValue {
                print(currentPage)
                delegate?.currentPageChanged(index: currentPage)

            }
            let cur = items[currentPage]
            delegate?.updateText(title: cur.title ?? "")
        }
    }
    var items = [LandingModel]() {
        didSet {
            delegate.reloadCollectionData()
        }
    }
    
    init(delegate: LandingViewControllerDelegate) {
        self.delegate = delegate
        items = [LandingModel(title: "The hardest choices require the strongest wills", description: "", image: "landing1"),
                 LandingModel(title: "Trust yourself, trust your power", description: "", image: "landing2"),
                 LandingModel(title: "You seek love. It’s all any of us want.", description: "", image: "landing3")]
        let cur = items[0]
        delegate.updateText(title: cur.title ?? "")
        
    }
    
}
extension LandingViewControllerPresenter{
    func getItemsCount() -> Int {
        return items.count
    }
    func configure(cell: IntroductionCollectionViewCellDelegate, for index: Int) {
        let item = items[index]
        
        cell.displayData(image: item.image ?? "")
    }
}
