//
//  DescriptionViewController.swift
//  API-Rick&Morty
//
//  Created by Luiz Antonio Bolsoni Riboli on 15/04/19.
//  Copyright © 2019 Adriano Ramos. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    
    var character: Character?
    var teste: CharacterTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = character?.name
        if let status = character?.status {
            statusLabel.text = "\(status)"
        }
        
        if let species = character?.species {
            speciesLabel.text = "\(species)"
        }
        
        if let gender = character?.gender{
            genderLabel.text = "\(gender)"
        }
        
        if let path = character?.imagePath, let url = URL(string: path){
             characterImageView.kf.setImage(with: url)
        }
    }
}
