//
//  MenuViewController.swift
//  SIISlideMenuTemplate
//
//  Created by Jeremie RICHARD on 17/02/2016.
//  Copyright © 2016 Jeremie RICHARD. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController, SIIMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: SIIMenuDelegate protocol implementation
    var mainNavigationController : UINavigationController?
    
    var associatedStoryboardID : [NSIndexPath:AnyObject] {
        let associatedIDsBySection = [
            NSIndexPath(forRow: 0, inSection: 0):"Page1", NSIndexPath(forRow: 1, inSection: 0):"Page2", NSIndexPath(forRow: 2, inSection: 0):"Page3",//section 1
            NSIndexPath(forRow: 0, inSection: 1):"Page1", NSIndexPath(forRow: 1, inSection: 1):"Page2", NSIndexPath(forRow: 2, inSection: 1):"Page3" //section 2
        ]
        
        return associatedIDsBySection
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let storyboardID = associatedStoryboardID[indexPath] as? String,
            vc = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) {
                NSNotificationCenter.defaultCenter().postNotificationName(NOTIF_TOGGLE_MENU, object: nil)
                mainNavigationController!.setViewControllers([vc], animated: true)
        }
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
