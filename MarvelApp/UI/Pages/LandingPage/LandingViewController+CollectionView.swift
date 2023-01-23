//
//  LandingViewController+CollectionView.swift
//  MarvelApp
//
//  Created by Ali Merhie on 10/7/20.
//  Copyright © 2020 Ali Merhie. All rights reserved.
//

import Foundation
import UIKit

extension LandingViewController {
    
    
    func setupCollectionView(){
         collectionView.dataSource = self
         collectionView.delegate = self
         collectionView.isPagingEnabled = true
//         self.collectionView.frame = collectionView.frame.insetBy(dx: -50.0, dy: 0.0)
        // collectionView.contentInset.left = 20
         collectionView.register(UINib.init(nibName: cellIdentinfier, bundle: nil), forCellWithReuseIdentifier: cellIdentinfier)
         
         if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
             layout.minimumLineSpacing = 0
             layout.minimumInteritemSpacing = 0
             layout.scrollDirection = .vertical
         }
    }
     private var collectionViewCurrentPage: Int {
            let pageHight = collectionView.frame.height
            var currentPage = Float(collectionView.contentOffset.y / pageHight)
        let itemsCount = presenter.getItemsCount()
            
            if fmodf(currentPage, 1) != 0 {
                currentPage = currentPage + 1
            }
            
            if itemsCount > 0 && Int(currentPage) >= itemsCount {
                return itemsCount - 1
            }
            
            return Int(currentPage)
        }
        
        @objc func scrollToNextPage() {
            let itemsCount = presenter.getItemsCount()
            var currentPage = presenter.currentPage
            currentPage += 1
            
            if itemsCount > 0 && currentPage >= itemsCount {
                currentPage = 0
            }
            let indexPath = IndexPath(row: currentPage, section: 0)
            collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true

        }
        public func reCentralizeCells(){
            self.collectionView.scrollToItem(at: IndexPath(row: presenter.currentPage, section: 0), at: .centeredHorizontally, animated: true)

        }
}
extension LandingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentinfier, for: indexPath) as! IntroductionCollectionViewCell
        presenter.configure(cell: cell, for: indexPath.row)

        return cell
    }
}

extension LandingViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        presenter.currentPage = collectionViewCurrentPage
//        updateButtonWidth()
    }
    //center cells
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        presenter.currentPage = collectionViewCurrentPage
//
//        if scrollView == self.collectionView {
//            var currentCellOffset = self.collectionView.contentOffset
//            currentCellOffset.x += self.collectionView.frame.width / 2
//            if let indexPath = self.collectionView.indexPathForItem(at: currentCellOffset) {
//                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            }
//        }
//    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        presenter.currentPage = collectionViewCurrentPage
//        updateButtonWidth()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let item = items[indexPath.row]
    }
    
    
}

extension LandingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}
