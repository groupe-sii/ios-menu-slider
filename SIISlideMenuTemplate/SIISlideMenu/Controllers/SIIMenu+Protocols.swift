//
//  SIIMenu+Protocols.swift
//  SIISlideMenuTemplate
//
//  Created by Jeremie RICHARD on 17/02/2016.
//  Copyright © 2016 Jeremie RICHARD. All rights reserved.
//

import UIKit

protocol SIIMenuDelegate {
    /**
     Pointer to main navigation ocntroller
     */
    var mainNavigationController : UINavigationController? { get set }
    /**
     Dictionary linking a View Controller storyboard ID to an index path
     */
    var associatedStoryboardID : [NSIndexPath:AnyObject] { get }
}

protocol SIIMenuCommonViewControllerBehaviour {
    /**
     Customize Hamburger button with your own design
     */
    var hamburgerButton : UIBarButtonItem { get }
    /**
     Invoked method when user tap on hamburger button
     */
    func onTapHamburgerButton(button:UIBarButtonItem)
    /**
     Implement this method to define how to add item to navigation bar
     */
    func willAddItemToNavigationBar()
}