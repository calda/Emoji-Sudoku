//
//  ViewController.swift
//  Emoji Sudoku
//
//  Created by Cal on 11/11/17.
//  Copyright (c) 2017 Cal Stephens. All rights reserved.
//

import UIKit
import WatchKit_iOS

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        let watchViewController = WatchContainerViewController.create(
            withInterfaceFileNamed: "Watch Interface",
            inNamespace: "Emoji Sudoku")
        
        watchViewController.modalTransitionStyle = .crossDissolve
        watchViewController.modalPresentationStyle = .overFullScreen
        self.present(watchViewController, animated: true, completion: nil)
    }
    
}
