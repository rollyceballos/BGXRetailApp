//
//  RoundedCornerImageView.swift
//  DesignableUI
//
//  Created by Rolly Ceballos on 06/23/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import UIKit

@IBDesignable
open class RoundedCornerImageView : UIImageView {
    @IBInspectable public var cornerRadius: CGFloat = 15 {
        didSet {
            refreshView(radius: cornerRadius)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFeaturedImageView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFeaturedImageView()
    }
    
    override open func prepareForInterfaceBuilder() {
        initFeaturedImageView()
    }
    
    private func initFeaturedImageView() {
        refreshView(radius: cornerRadius)
    }
    
    private func refreshView(radius value: CGFloat) {
        layer.cornerRadius = value
    }
}

