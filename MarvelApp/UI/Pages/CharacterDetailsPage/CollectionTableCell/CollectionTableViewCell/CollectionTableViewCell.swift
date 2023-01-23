//
//  CollectionTableViewCell.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit
import SkeletonView
import Combine

class CollectionTableViewCell: UITableViewCell {
    var cancellables = Set<AnyCancellable>()

    let cellIdentinfier = "ItemCollectionViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    var viewModel = CollectionTableVM()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindToViewModel()
        setupCollectionView()
        // Initialization code
    }
    func bindToViewModel() {
        
        viewModel.$reloadCollectionView
            .sink(self) { _, strongSelf in
                strongSelf.collectionView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$showEmptyCollection
            .sink(self) { _, strongSelf in
                strongSelf.collectionView.showEmptyDataSet(title: "No \(strongSelf.titleLabel.text ?? "") Data")
            }.store(in: &cancellables)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(data: [CollectionItemProtocol], title: String){
        titleLabel.text = title
        viewModel.items = data
    }
}

extension CollectionTableViewCell: SkeletonCollectionViewDataSource {
    
    func setupCollectionView(){
         collectionView.dataSource = self
        collectionView.delegate = self
         collectionView.register(UINib.init(nibName: cellIdentinfier, bundle: nil), forCellWithReuseIdentifier: cellIdentinfier)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentinfier, for: indexPath) as! ItemCollectionViewCell
        cell.configureItem(item: viewModel.getItem(at: indexPath))
        return cell
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentinfier
    }
    
}
extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return  CGSize(width: collectionView.bounds.size.width/4, height: collectionView.bounds.height)
    }
    
}
