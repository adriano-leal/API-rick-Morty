//
//  TesteViewController.swift
//  API-Rick&Morty
//
//  Created by Luiz Antonio Bolsoni Riboli on 15/04/19.
//  Copyright © 2019 Adriano Ramos. All rights reserved.
//

import UIKit

class TesteViewController: UIViewController {

    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCharacterInfo()
    }
    
    func retrieveCharacterInfo(){
        if let url = URL(string: "https://rickandmortyapi.com/api/character/2"){
            let task = URLSession.shared.dataTask(with: url) { (data, request, error) in
                if error == nil {
                    if let returnedData = data {
                        do{
                            if let jsonElement = try JSONSerialization.jsonObject(with: returnedData, options: []) as? [String: Any]{
                                if let getName = jsonElement["name"] as? String{
                                    DispatchQueue.main.async(execute: {
                                        self.nameLabel.text = getName
                                    })
                                }
                                if let getSpecies = jsonElement["species"] as? String{
                                    DispatchQueue.main.async(execute: {
                                        self.speciesLabel.text = getSpecies
                                    })
                                }
                                if let getGender = jsonElement["gender"] as? String{
                                    DispatchQueue.main.async(execute: {
                                        self.genderLabel.text = getGender
                                    })
                                }
//                                if let getImage = jsonElement["image"] as? String{
//                                    self.downloadImage()
//                                }
                            }
                        } catch {
                            print("Error while fetching character info.")
                        }
                    }
                } else {
                    print("Unable to fetch character info.")
                }
            }
            task.resume()
        }
    }
    
    func downloadImage(){
        if let url = URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"){
            let fetchImage = URLSession.shared.dataTask(with: url) { (data, request, error) in
                if error == nil {
                    if let returnedData = data {
                        let image = UIImage(data: returnedData)
                        DispatchQueue.main.async(execute: {
                            self.characterImageView.image = image
                        })
                    }
                }
            }
            fetchImage.resume()
        }
    }


}
