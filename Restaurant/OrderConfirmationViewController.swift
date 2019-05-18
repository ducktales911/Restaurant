//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Thomas Hamburger on 12/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes"
    }

}
