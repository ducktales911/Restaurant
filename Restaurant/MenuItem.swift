//
//  MenuItem.swift
//  Restaurant
//
//  Created by Thomas Hamburger on 11/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import Foundation

// Bevat properties die corresponderen met de keys in elke dictionary.
struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}

// Bevat alle MenuItem structs die door de API gegeven als JSON array gegeven worden.
struct MenuItems: Codable {
    let items: [MenuItem]
}
