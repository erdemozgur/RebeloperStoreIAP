//
//  UINavigationController+.swift
//  DuckUI
//
//  Created by Alex Nagy on 02/07/2019.
//

import UIKit

extension UINavigationController {
    
    /// Hides the navigation item background. Does show the navigation items
    open func setNavigationItemBackground(hidden: Bool) {
        if hidden {
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
            self.view.backgroundColor = UIColor.clear
        } else {
            //        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            //        self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = false
            self.view.backgroundColor = UIColor.white
        }
        
    }
    
    open func execute(_ transitionType: CATransitionType, _ controller: UIViewController, _ from: CATransitionSubtype, duration: CFTimeInterval = 0.3, timingFunctionName: CAMediaTimingFunctionName = .default) {
        var subtype = from
        switch from {
        case .fromTop:
            subtype = .fromBottom
        case .fromBottom:
            subtype = .fromTop
        case .fromLeft:
            subtype = .fromLeft
        case .fromRight:
            subtype = .fromRight
        default:
            subtype = from
        }
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        view.window!.layer.add(transition, forKey: kCATransition)
        pushViewController(controller, animated: false)
    }
    
    open func pop(_ to: D_TransitionSubtype, _ transitionType: CATransitionType = .push, duration: CFTimeInterval = 0.3, timingFunctionName: CAMediaTimingFunctionName = .default) {
        var subtype: CATransitionSubtype = .fromLeft
        switch to {
        case .toTop:
            subtype = .fromTop
        case .toBottom:
            subtype = .fromBottom
        case .toLeft:
            subtype = .fromRight
        case .toRight:
            subtype = .fromLeft
        }
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
    }
    
    open func popToRootViewController(_ from: CATransitionSubtype, _ transitionType: CATransitionType = .push, duration: CFTimeInterval = 0.3, timingFunctionName: CAMediaTimingFunctionName = .linear) {
        var subtype = from
        switch from {
        case .fromTop:
            subtype = .fromBottom
        case .fromBottom:
            subtype = .fromTop
        case .fromLeft:
            subtype = .fromRight
        case .fromRight:
            subtype = .fromLeft
        default:
            subtype = from
        }
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        view.window!.layer.add(transition, forKey: kCATransition)
        popToRootViewController(animated: false)
    }
    
}

