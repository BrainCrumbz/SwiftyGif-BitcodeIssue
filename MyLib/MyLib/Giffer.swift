//
//  Giffer.swift
//  MyLib
//
//  Created by BrainCrumbz on 28/05/19.
//  Copyright © 2019 BrainCrumbz. All rights reserved.
//

import Foundation

import SwiftyGif

public class Giffer {
    
    public init() {
        // do nothing
    }
    
    public func build(fullname: String) -> UIImageView {
        let image = UIImage(gifName: fullname)
        
        let imageView = UIImageView(gifImage: image)
        
        return imageView
    }
}
