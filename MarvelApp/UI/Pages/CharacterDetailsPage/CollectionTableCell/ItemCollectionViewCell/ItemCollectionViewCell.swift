//
//  ItemCollectionViewCell.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureItem(item: CollectionItemProtocol){
        _ = itemImageView.setKfImage(url: item.imageUrl, imageName: "")
        titleLabel.text = item.titleText
    }
}
