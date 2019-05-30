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
        
        print("addition: \(result)")
        
        let giffer = Giffer()
        
        let imageView = giffer.build(fullname: "3.gif")
        
        print("gif size: \(imageView.frameAtIndex(index: 0).size)")
    }
}
