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
    @IBOutlet weak var featuredImageView: FeaturedImageView!
    
    override func prepareForReuse() {
        featuredImageView.image = nil
    }
    
    override func prepareForInterfaceBuilder() {
        featuredImageView.image = UIImage(named: "collection-bbq")
    }
}

class FeaturedFoodCollectionCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: FeaturedImageView!

    override func prepareForReuse() {
        featuredImageView.image = nil
    }
    
    override func prepareForInterfaceBuilder() {
        featuredImageView.image = UIImage(named: "food-banana")
    }
}

class HotDealCollectionCell : UICollectionViewCell {
    @IBOutlet weak var hotDealImageView: UIImageView!
    
    override func prepareForReuse() {
        hotDealImageView.image = nil
    }
    
    override func prepareForInterfaceBuilder() {
        hotDealImageView.image = UIImage(named: "collection-cream")
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
