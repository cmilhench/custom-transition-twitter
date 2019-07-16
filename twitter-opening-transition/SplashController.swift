//
//  SplashController.swift
//  twitter-opening-transition
//
//  Created by Colin Milhench on 16/07/2019.
//  Copyright © 2019 Colin Milhench. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainApplication")
        self.present(controller, animated: true, completion: nil)
    }

}
