//
//  ViewController.swift
//  MyApp
//
//  Created by BrainCrumbz on 28/05/19.
//  Copyright © 2019 BrainCrumbz. All rights reserved.
//

import UIKit
import MyLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let adder = Adder()
        
        let result = adder.add(a: 1, b: 2)
        
        print("result: \(result)")
    }
}
