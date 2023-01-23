//
//  DetailsHeaderView.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit

class DetailsHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureHeader(character: CharacterModel?){
        guard let character = character else {return}
        _ = imageView.setKfImage(url: character.thumbnail?.getImageURL(), imageName: "\(character.id ?? 0)")
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
}
