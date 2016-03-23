//
//  CommonViewController.swift
//  SIISlideMenuTemplate
//
//  Created by Jeremie RICHARD on 17/02/2016.
//  Copyright © 2016 Jeremie RICHARD. All rights reserved.
//

import UIKit

class CommonViewController: SIIMenuCommonViewController, SIIMenuCommonViewControllerBehaviour {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SIICommonViewControllerMenuBehaviour protocol implementation
    var hamburgerButton : UIBarButtonItem {
        return UIBarButtonItem(title: "|||", style: .Plain, target: self, action: #selector(CommonViewController.onTapHamburgerButton(_:)))
    }
    func onTapHamburgerButton(button: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIF_TOGGLE_MENU, object: button)
    }
    override func willAddItemToNavigationBar() {
        self.navigationItem.leftBarButtonItem = hamburgerButton
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
