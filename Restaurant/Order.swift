//
//  Order.swift
//  Restaurant
//
//  Created by Thomas Hamburger on 11/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import Foundation

// Bevat een lijst van items die de gebruiker toegevoegd heeft.
struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
