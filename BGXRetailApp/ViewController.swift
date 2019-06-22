//
//  ViewController.swift
//  BGXRetailApp
//
//  Created by Rolly on 06/21/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var featuredStoresCollectionView: UICollectionView!
    @IBOutlet var featuredFoodCollectionView: UICollectionView!
    @IBOutlet var hotDealsCollectionView: UICollectionView!
    private var featuredStoresDataSource : UICollectionViewDataSource?
    private var featuredCollectionDataSource : UICollectionViewDataSource?
    private var hotDealsCollectionDataSource : UICollectionViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        initFeaturedStore()
        initFeaturedCollections()
        initHotDeals()
    }

}


extension ViewController {
    private func initFeaturedStore() {
        let images = [
            UIImage(named: "collection-salad"),
            UIImage(named: "collection-cream"),
            UIImage(named: "collection-barbecue-beef")
        ]
        
        let dataSource = FeaturedStoreDataSource(images, reuseIdentifier: "FeaturedStoreCell") { (image, cell) -> UICollectionViewCell in
            if let featuredCell = cell as? FeaturedStoreCell {
                featuredCell.featuredImageView.image = image
            }
            
            return cell
        }
        
        self.featuredStoresDataSource = dataSource
        
        featuredStoresCollectionView.dataSource = dataSource
    }
    
    private func initFeaturedCollections() {
        let images = [
            UIImage(named: "food-banana"),
            UIImage(named: "food-bread"),
            UIImage(named: "food-baked-goods"),
       ]
        
        let dataSource = FeaturedStoreDataSource(images, reuseIdentifier: "FeaturedCollectionCell") { (image, cell) -> UICollectionViewCell in
            if let featuredCell = cell as? FeaturedFoodCollectionCell {
                featuredCell.featuredImageView.image = image
//                featuredCell.featuredImageView.cornerRadius = cell.frame.height / 4
            }
            
            return cell
        }
        
        self.featuredCollectionDataSource = dataSource
        
        featuredFoodCollectionView.dataSource = dataSource
    }
    
    func initHotDeals() {
        let images = [
            UIImage(named: "collection-cream"),
        ]
        
        let dataSource = FeaturedStoreDataSource(images, reuseIdentifier: "HotDealCell") { (image, cell) -> UICollectionViewCell in
            if let featuredCell = cell as? HotDealCollectionCell {
                featuredCell.hotDealImageView.image = image
            }
            
            return cell
        }
        
        self.hotDealsCollectionDataSource = dataSource

        hotDealsCollectionView.dataSource = dataSource
    }
}
