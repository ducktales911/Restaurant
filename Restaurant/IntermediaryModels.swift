//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Thomas Hamburger on 11/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import Foundation

// Intermediary model die alle categoriën bevat die de API geeft.
struct Categories: Codable {
    let categories: [String]
}

// Intermediary model voor preparation_time voor een enkel MenuItem.
struct PreparationTime: Codable {
    let prepTime: Int

    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
