//
//  CharacterTableView.swift
//  API-Rick&Morty
//
//  Created by Adriano Ramos on 14/04/19.
//  Copyright © 2019 Adriano Ramos. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //characterImageView.layer.cornerRadius =
    }
    

}
