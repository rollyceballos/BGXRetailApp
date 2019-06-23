//
//  UIView+Extensions.swift
//  BGXRetailApp
//
//  Created by Rolly Ceballos on 06/23/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    final func fadeInOut() {
        UIView.animate(withDuration: 0.5 ,
                       delay: 0, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
                        self.contentView.alpha = 0
        }, completion: nil)
    }
}

extension UICollectionView {
    final func animate(with dataSource:UICollectionViewDataSource) {
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 0
        }) { (complete) in
            UIView.animate(withDuration: 1) {
                self.alpha = 1
                self.dataSource = dataSource
            }
        }
    }
}
