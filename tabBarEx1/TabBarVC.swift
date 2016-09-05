//
//  TabBarVC.swift
//  tabBarEx1
//
//  Created by Xavier Jorda Murria on 04/09/2016.
//  Copyright © 2016 intrasonics. All rights reserved.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let tabBarController = TabBarVC() //Tab bar controller with model
        
        self.delegate = self
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller1 = storyBoard.instantiateViewControllerWithIdentifier("LeftScreen") as! LeftScreenVC
        let controller2 = storyBoard.instantiateViewControllerWithIdentifier("MainScreen") as! MainScreenVC
        let controller3 = storyBoard.instantiateViewControllerWithIdentifier("RightScreen") as! RightScreenVC
        
        let controllers = [controller1,controller2,controller3]
        
        self.viewControllers = controllers
//        window?.rootViewController = tabBarController
        
        //        let MainImage = UIImage(named: "ISIcone")
        //        let LeftImage = UIImage(named: "LeftItem")
        //        let RightImage = UIImage(named: "RightItem")
        
        controller1.tabBarItem = UITabBarItem(
            title: "Left",
            image: nil,
            tag: 0)
        controller2.tabBarItem = UITabBarItem(
            title: "Main",
            image: nil,
            tag:1)
        
        controller3.tabBarItem = UITabBarItem(
            title: "Right",
            image: nil,
            tag:2)
        
        //Making Starting screen as a Main.
        self.selectedIndex = 1
        
        //Making the item tab bar with index 1 unclicable as we just 
        //want to access to the MainScreen using the IS button and not the Behind item.
        self.tabBar.items![1].enabled = false
        
        setupMiddleButton()
    }
    
    func setupMiddleButton()
    {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        //        menuButton.backgroundColor = UIColor.redColor()
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        self.view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "ISIcone"), forState: UIControlState.Normal)
        menuButton.addTarget(self, action: #selector(TabBarVC.menuButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        menuButton.userInteractionEnabled = true
        menuButton.enabled = true
        menuButton.pulse()
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Actions
    
    func menuButtonAction(sender: UIButton)
    {
        self.selectedIndex = 1
        sender.layer.removeAllAnimations()
    }
    
    // MARK: - UITabBarControllerDelegate Methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    {
        let tabViewControllers = tabBarController.viewControllers!
        guard let toIndex = tabViewControllers.indexOf(viewController)
        else {return false}
        
        // Our method
        animateToTab(toIndex)
        
        return true
    }
    
    
    // MARK: - Private Methods
    private func animateToTab(toIndex: Int)
    {
        let tabViewControllers = viewControllers!
        let fromView = selectedViewController!.view
        let toView = tabViewControllers[toIndex].view
        let fromIndex = tabViewControllers.indexOf(selectedViewController!)
        
        guard fromIndex != toIndex else {return}
        
        // Add the toView to the tab bar view
        fromView.superview!.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        let scrollRight = toIndex > fromIndex;
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        // Disable interaction during animation
        view.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y);
            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y);
            
            }, completion: { finished in
                
                // Remove the old view from the tabbar view.
                fromView.removeFromSuperview()
                self.selectedIndex = toIndex
                self.view.userInteractionEnabled = true
        })
    }
    
    
}