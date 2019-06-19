//
//  StyledNavigationController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 11/11/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit

class StyledNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let font = UIFont(name: "Avenir-Heavy", size: 21) else {
            return
        }
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor : UIColor.scPurple,
             NSAttributedString.Key.font : font]
    }

}
