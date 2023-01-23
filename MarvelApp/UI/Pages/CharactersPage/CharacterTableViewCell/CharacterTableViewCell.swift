//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(character: CharacterModel){
        _ = characterImageView.setKfImage(url: character.thumbnail?.getImageURL(), imageName: "\(character.id ?? 0)")
        nameLabel.text = character.name
    }
}
