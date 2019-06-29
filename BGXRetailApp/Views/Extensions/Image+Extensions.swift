//
//  Image+Extensions.swift
//  GithubDM
//
//  Created by Rolly Ceballos on 11/11/2018.
//  Copyright © 2018 Beagleworx Labs. All rights reserved.
//

import UIKit

extension UIImage {
    static func from(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return img
    }
}
