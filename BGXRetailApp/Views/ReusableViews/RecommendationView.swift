//
//  RecommendationView.swift
//  BGXRetailApp
//
//  Created by Rolly Ceballos on 06/30/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import UIKit

class RecommendationView: UIStackView {
    class func instanceFromNib() -> UIView? {
        UINib(nibName: "RecommendationView", bundle: nil).instantiate(withOwner: nil, options: nil).first
            as? RecommendationView
    }
}

class RecommendationController: UIViewController {

    private weak var stackView: UIStackView?
    
    func append(to controller:UIViewController, in stackView:UIStackView) {
        controller.addChild(self)
        stackView.addArrangedSubview(view)
        didMove(toParent: controller)
    }
    
    func remove() {
        guard let _ = parent else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
