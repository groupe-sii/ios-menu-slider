//
//  SIIMenuCommonViewController.swift
//  SIISlideMenuTemplate
//
//  Created by Jeremie RICHARD on 17/02/2016.
//  Copyright © 2016 Jeremie RICHARD. All rights reserved.
//

import UIKit

class SIIMenuCommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        willAddItemToNavigationBar()
        // Do any additional setup after loading the view.
    }

    func willAddItemToNavigationBar() {
        // this will be implemented in subclass
    }

}
