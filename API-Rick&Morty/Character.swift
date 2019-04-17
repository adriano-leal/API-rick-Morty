//
//  File.swift
//  API-Rick&Morty
//
//  Created by Adriano Ramos on 14/04/19.
//  Copyright © 2019 Adriano Ramos. All rights reserved.
//

import Foundation

struct Character {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
//    var origin: String
    var imageData: Data?
    var imagePath: String?
}
