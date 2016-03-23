//
//  SIIMenuWrapperViewController.swift
//  SIISlideMenuTemplate
//
//  Created by Jérémie Richard on 11/02/2016.
//  Copyright © 2016 SII. All rights reserved.
//

import UIKit

class SIIMenuWrapperViewController: UIViewController {
    
    var containerViewController: SIIMenuContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embeddedMenuSegue" {
            var menuVC = segue.destinationViewController as! SIIMenuDelegate
            menuVC.mainNavigationController = containerViewController?.mainNavigationController
        }
    }

}
