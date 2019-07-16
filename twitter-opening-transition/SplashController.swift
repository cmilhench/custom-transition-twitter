//
//  SplashController.swift
//  twitter-opening-transition
//
//  Created by Colin Milhench on 16/07/2019.
//  Copyright © 2019 Colin Milhench. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    fileprivate var transition: SplashTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transition = SplashTransition()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainApplication")
        controller.transitioningDelegate = self.transition
        self.present(controller, animated: true, completion: nil)
    }

}
