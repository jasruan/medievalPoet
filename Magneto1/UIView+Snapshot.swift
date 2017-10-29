//
//  UIView+Snapshot.swift
//  Magneto1
//
//  Created by Jasmine Ruan (RIT Student) on 3/20/17.
//  Copyright © 2017 igmstu. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func takeSnapshot() -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
