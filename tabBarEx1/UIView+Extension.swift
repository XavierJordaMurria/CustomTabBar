//
//  UIView+Extension.swift
//  tabBarEx1
//
//  Created by Xavier Jorda Murria on 04/09/2016.
//  Copyright © 2016 intrasonics. All rights reserved.
//

import UIKit

extension UIView
{
    func shake()
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.4
        animation.values = [-10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.addAnimation(animation, forKey: "shake")
    }
    
    func pulse()
    {
        //make the view has one heartBeat
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.9
        
        //make the view alive having an infinite sequence of heartBeats
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [pulse1]
        
        layer.addAnimation(animationGroup, forKey: "pulse")
    }
}