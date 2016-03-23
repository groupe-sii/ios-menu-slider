//
//  SIIMenuContainerViewController.swift
//  SIISlideMenuTemplate
//
//  Created by Jérémie Richard on 11/02/2016.
//  Copyright © 2016 SII. All rights reserved.
//

import UIKit

/**
    Name of notification to toggle menu
*/
let NOTIF_TOGGLE_MENU = "SII_NOTIF_TOGGLE_MENU"

class SIIMenuContainerViewController: UIViewController {
    
    @IBOutlet weak var leftView: UIView!
    var leftViewController: UIViewController? {
        willSet {
            if self.leftViewController != nil {
                if self.leftViewController!.view != nil {
                    self.leftViewController!.view!.removeFromSuperview()
                }
                self.leftViewController!.removeFromParentViewController()
            }
        }
        
        didSet {
            let subview = self.leftViewController!.view
            subview.frame = leftView.bounds
            leftView.addSubview(subview)
            self.addChildViewController(self.leftViewController!)
        }
    }
    
    @IBOutlet weak var constraintRightViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintRightViewLeading: NSLayoutConstraint!
    @IBOutlet weak var rightView: UIView!
    var rightViewController: UIViewController? {
        willSet {
            if self.rightViewController != nil {
                if self.rightViewController!.view != nil {
                    self.rightViewController!.view!.removeFromSuperview()
                }
                self.rightViewController!.removeFromParentViewController()
            }
        }
        
        didSet {
            let subview = self.rightViewController!.view
            subview.frame = rightView.bounds
            rightView.addSubview(subview)
            self.addChildViewController(self.rightViewController!)
        }
    }
    
    var menuShown: Bool = false
    var mainNavigationController: UINavigationController?
    
    var leftEdgeRecognizer: UIScreenEdgePanGestureRecognizer?
    var rightEdgeRecognizer: UIScreenEdgePanGestureRecognizer?
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as? UINavigationController
        let menuWrapperViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SIIMenuWrapperViewController") as? SIIMenuWrapperViewController

        menuWrapperViewController?.containerViewController = self
        
        self.leftViewController = menuWrapperViewController
        self.rightViewController = mainNavigationController
        
        // Add shadow
        self.rightViewController!.view.layer.shadowColor = UIColor.blackColor().CGColor
        self.rightViewController!.view.layer.shadowOffset = CGSize(width: -8, height: 5)
        self.rightViewController!.view.layer.shadowOpacity = 0.6
        self.rightViewController!.view.layer.shadowRadius = 4
        
        // Add Gestures
        leftEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SIIMenuContainerViewController.onSwipe(_:)))
        leftEdgeRecognizer!.edges = .Left
        rightView.addGestureRecognizer(leftEdgeRecognizer!)
        
        rightEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SIIMenuContainerViewController.onSwipe(_:)))
        rightEdgeRecognizer!.edges = .Right
        rightView.addGestureRecognizer(rightEdgeRecognizer!)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SIIMenuContainerViewController.onTap(_:)))
        tapGesture.cancelsTouchesInView = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SIIMenuContainerViewController.toggleMenu), name: NOTIF_TOGGLE_MENU, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: Animations
    
    func showMenu() {
        if !menuShown {
            UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                self.constraintRightViewLeading.constant = (self.view.frame.width * 2/3)
                self.constraintRightViewTrailing.constant = -self.constraintRightViewLeading.constant
                self.rightView.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    self.menuShown = true
            })
            
            self.rightView.addGestureRecognizer(tapGesture)
            let topVC = mainNavigationController!.viewControllers.last
            topVC!.view.userInteractionEnabled = false
        }
    }
    
    func hideMenu() {
        if menuShown {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                self.constraintRightViewLeading.constant = 0
                self.constraintRightViewTrailing.constant = 0
                self.rightView.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    self.menuShown = false
            })
            
            self.rightView.removeGestureRecognizer(tapGesture)
            let topVC = mainNavigationController!.viewControllers.last
            topVC!.view.userInteractionEnabled = true
        }
    }
    
    func onSwipe(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Ended {
            if sender == leftEdgeRecognizer {
                showMenu()
            } else if sender == rightEdgeRecognizer {
                hideMenu()
            }
        }
    }
    
    func onTap(sender: UITapGestureRecognizer) {
        if menuShown {
            hideMenu()
        }
    }
    
    func toggleMenu() {
        if menuShown {
            hideMenu()
        } else {
            showMenu()
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition({
            context in
                if self.menuShown {
                    self.constraintRightViewLeading.constant = (size.width * 2/3)
                    self.constraintRightViewTrailing.constant = -self.constraintRightViewLeading.constant
                    self.rightViewController = self.mainNavigationController
                    self.view.layoutIfNeeded()
                }
            }, completion: { context in
                
        })
    }
}
