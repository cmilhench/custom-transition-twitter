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
        let frame = CGRect(x: container.bounds.size.width/2-25, y: container.bounds.size.height/2-25, width: 50, height: 50)
        let start = UIBezierPath(ovalIn: frame).cgPath

        // Calculate the end point
        let point = CGPoint(x: frame.midX, y: frame.midY - toView.bounds.height)
        let radius = sqrt((point.x*point.x) + (point.y*point.y));
        let finish = UIBezierPath.init(ovalIn: frame.insetBy(dx: -radius, dy: -radius)).cgPath

        // Create the animation
        let animation = CAKeyframeAnimation.init(keyPath: "path")
        animation.beginTime = CACurrentMediaTime();
        animation.duration = self.transitionDuration(using:transitionContext)
        animation.delegate = self;
        animation.repeatCount = 1;
        animation.timingFunctions = [CAMediaTimingFunction(name:.easeInEaseOut)]
        animation.values = [start, finish];
        animation.keyTimes = [0, self.transitionDuration(using:transitionContext)] as [NSNumber]

        // Create the layer
        let layer = CAShapeLayer()
        layer.path = start;
        layer.add(animation, forKey: "path")
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
