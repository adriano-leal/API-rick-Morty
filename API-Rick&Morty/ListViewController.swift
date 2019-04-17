//
//  ListViewController.swift
//  API-Rick&Morty
//
//  Created by Luiz Antonio Bolsoni Riboli on 15/04/19.
//  Copyright © 2019 Adriano Ramos. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    
    var characterIndex = 1
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCharacters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        retrieveCharacterInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? Character, let nextViewController = segue.destination as? DescriptionViewController {
            nextViewController.character = cell
        }
    }
    
//    func downloadImage(completionHandler completion: @escaping (Data?) -> Void) {
//        if let urlImage = URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"){
//            let fetchImage = URLSession.shared.dataTask(with: urlImage) { (data, request, error) in
//                completion(data)
//            }
//            fetchImage.resume()
//        }
//    }
    
    var isDownloading: Bool = false
    var page: Int = 1;
    
    func retrieveCharacterInfo(){
        var character =  Character(id: 0, name: "", status: "", species: "", gender: "", imageData: nil, imagePath: nil)
        var characters: [Character] = []
        
        if let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") {
            let task = URLSession.shared.dataTask(with: url) { (data, request, error) in
                if error == nil {
                    if let returnedData = data {
                        do {
                            if let jsonElement = try JSONSerialization.jsonObject(with: returnedData, options: []) as? [String: Any],
                                let charactersResult = jsonElement["results"] as? [[String: Any]] {
                                for ch in charactersResult {
                                    if let getName = ch["name"] as? String{
                                        character.name = getName
                                    }
                                    if let getStatus = ch["status"] as? String{
                                        character.status = getStatus
                                    }
                                    if let getSpecies = ch["species"] as? String{
                                        character.species = getSpecies
                                    }
                                    if let getGender = ch["gender"] as? String{
                                        character.gender = getGender
                                    }
                                    if let getImage = ch["image"] as? String {
                                        character.imagePath = getImage
                                    }
                                    
                                    characters.append(character)
                                }
                                DispatchQueue.main.async {
                                    self.isDownloading = false
                                    self.page += 1
                                    self.arrayCharacters.append(contentsOf: characters)
                                    self.tableView.reloadData()
                                }
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
}

extension ListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayCharacters.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 13
    }
    
    // Change height of row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140 //or whatever you need
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
//        cell.characterImageView.layer.cornerRadius = 40
        
        if arrayCharacters.count != 0 {
            print("teste \(arrayCharacters.count)")
            print("teste2 \(arrayCharacters)")
            
            let charInfo = arrayCharacters[indexPath.section]
            
            cell.nameLabel.text = charInfo.name
            cell.speciesLabel.text = charInfo.species
            cell.genderLabel.text = charInfo.gender
            
            if let path = charInfo.imagePath, let url = URL(string: path) {
                cell.characterImageView.kf.setImage(with: url)
            }
        }
        
        if indexPath.section+1 == arrayCharacters.count && isDownloading == false {
            isDownloading = true
            retrieveCharacterInfo()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

// MARK : Table View Delegate 
extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arrayCharacters[indexPath.section]
        performSegue(withIdentifier: "descriptionSegue", sender: obj)
        
    }
}

//extension ListViewController: UISearchBarDelegate{
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            if searchText.isEmpty {
//                filteredSessions0 = sessions0
//                filteredSessions1 = sessions1
//                filteredSessions2 = sessions2
//            } else {
//                filteredSessions0 = sessions0.filter( { $0.name.lowercased().contains(searchText.lowercased()) } )
//                filteredSessions1 = sessions1.filter( { $0.name.lowercased().contains(searchText.lowercased()) } )
//                filteredSessions2 = sessions2.filter( { $0.name.lowercased().contains(searchText.lowercased()) } )
//            }
//            tableView.reloadData()
//        }
//
//        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            searchBar.showsCancelButton = true
//        }
//
//        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.showsCancelButton = false
//            searchBar.text = ""
//            searchBar.resignFirstResponder()
//            filteredSessions0 = sessions0
//            filteredSessions1 = sessions1
//            filteredSessions2 = sessions2
//            tableView.reloadData()
//        }
//}
//
