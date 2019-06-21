//
//  FeaturedCell.swift
//  BGXRetailApp
//
//  Created by Rolly on 06/21/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import Foundation
import UIKit

class FeaturedStoreCell : UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    
    override func prepareForReuse() {
        featuredImageView.image = nil
    }
    
    override func prepareForInterfaceBuilder() {
        featuredImageView.image = UIImage(named: "appetizer-store")
    }
}

@IBDesignable class FeaturedImageView : UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshView(radius: cornerRadius)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFeaturedImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFeaturedImageView()
    }
    
    override func prepareForInterfaceBuilder() {
        initFeaturedImageView()
    }
    
    private func initFeaturedImageView() {
        refreshView(radius: cornerRadius)
    }
    
    private func refreshView(radius value: CGFloat) {
        layer.cornerRadius = value
    }
}
