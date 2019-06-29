//
//  FeaturedStoreData.swift
//  BGXRetailApp
//
//  Created by Rolly on 06/21/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import Foundation
import UIKit

class CollectionDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model,UICollectionViewCell) -> UICollectionViewCell
    private let models : [Model]
    private let reuseIdentifier : String
    private let cellConfigurator : CellConfigurator?
    
    init(_ models : [Model],
         reuseIdentifier: String,
         configurator: CellConfigurator?
        ) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = configurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let configurator = cellConfigurator else {
            return cell
        }

        let model = models[indexPath.row]
        
        return configurator(model,cell)
    }
}
