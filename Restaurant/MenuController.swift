//
//  MenuController.swift
//  Restaurant
//
//  Created by Thomas Hamburger on 11/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import Foundation
import UIKit

class MenuController {

    static let shared = MenuController()
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")

    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }

    let baseURL = URL(string: "http://localhost:8090/")!

    // Haalt categoriën op. Completion parameter zal de categoriën bevatten die door de server worden gegeven, of nil als de server niet op tijd reageert of als parsing faalt.
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
            let jsonDictionary = ((try? JSONSerialization.jsonObject(with: data) as? [String: Any]) as [String : Any]??),
            let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    // Haalt MenuItems op gegeven een categorie. Completion parameter zal de MenuItems bevatten die door de server worden gegeven, of nil als de server niet op tijd reageert of als parsing faalt.
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                    completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    // Haalt afbeelding op. Completion parameter ontvangt UIImage data die door de server wordt gegeven, of nil als de server niet op tijd reageert.
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    // Doet een POST request met een collectie van menu item IDs. De response bevat een integer met de voorbereidingstijd die wordt ontvangen door de completion parameter.
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}
