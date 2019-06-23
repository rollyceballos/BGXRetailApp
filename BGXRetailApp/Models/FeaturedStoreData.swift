//
//  FeaturedStoreData.swift
//  BGXRetailApp
//
//  Created by Rolly on 06/21/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import Foundation
import UIKit

class FeaturedStoreDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model,UICollectionViewCell) -> UICollectionViewCell
    private let featuredModels : [Model]
    private let reuseIdentifier : String
    private let cellConfigurator : CellConfigurator?
    
    init(_ models : [Model],
         reuseIdentifier: String,
         configurator: CellConfigurator?
        ) {
        featuredModels = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = configurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let configurator = cellConfigurator else {
            return cell
        }

        let model = featuredModels[indexPath.row]
        
        return configurator(model,cell)
    }
}
