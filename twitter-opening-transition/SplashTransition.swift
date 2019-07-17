//
//  SplashTransition.swift
//  twitter-opening-transition
//
//  Created by Colin Milhench on 16/07/2019.
//  Copyright © 2019 Colin Milhench. All rights reserved.
//

import UIKit

class SplashTransition: NSObject, UIViewControllerTransitioningDelegate {

    var context: UIViewControllerContextTransitioning?
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension SplashTransition : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // Defines how long an animation should take.
        let duration: TimeInterval = 0.7
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.context = transitionContext

        let toView = transitionContext.view(forKey: .to)!
        let container = transitionContext.containerView
        container.addSubview(toView)

        // Calculate the start point
        let start = CGRect(x: 0, y: 0, width: 100, height: 100)

        // Calculate the end point
        let finish = CGRect(x: 0, y: 0, width: 1000, height: 1000)

        // Create the animation
        let animation = CAKeyframeAnimation.init(keyPath: "bounds")
        animation.beginTime = CACurrentMediaTime();
        animation.duration = self.transitionDuration(using:transitionContext)
        animation.delegate = self;
        animation.repeatCount = 1;
        animation.timingFunctions = [CAMediaTimingFunction(name:.easeInEaseOut)]
        animation.values = [start, finish];
        animation.keyTimes = [0, self.transitionDuration(using:transitionContext)] as [NSNumber]

        // Create the layer
        let layer = CALayer()
        layer.contents = UIImage(named: "logo")?.cgImage
        layer.bounds = start
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.position = CGPoint(x: toView.frame.size.width/2, y: toView.frame.size.height/2)
        layer.add(animation, forKey: "bounds")
        toView.layer.mask = layer
    }
}

extension SplashTransition : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.context?.completeTransition(!(self.context?.transitionWasCancelled ?? false))
        let fromView = self.context?.view(forKey: .to)
        fromView?.layer.mask = nil
    }
}
