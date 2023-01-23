//
//  IntroductionCollectionViewCell.swift
//  MarvelApp
//
//  Created by Ali Merhie on 8/20/20.
//  Copyright © 2020 Ali Merhie. All rights reserved.
//

import UIKit
protocol IntroductionCollectionViewCellDelegate: AnyObject {
    func displayData(image: String)
}
class IntroductionCollectionViewCell: UICollectionViewCell, IntroductionCollectionViewCellDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayData(image: String) {
        

        imageView.image = UIImage(named: image)

    }
    
}
