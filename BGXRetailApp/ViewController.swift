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

        showInitialData()
        loadDynamicMockData()
    }

}


extension ViewController {
    private func showInitialData() {
        let dataSource = FeaturedStoreDataSource([UIImage?](repeating: nil, count: 1), reuseIdentifier: "LoadingFeaturedStoreCell") { (image, cell) -> UICollectionViewCell in
            cell.fadeInOut()
            
            return cell
        }
        
        self.featuredStoresDataSource = dataSource
        featuredStoresCollectionView.dataSource = dataSource
        
        let dataSource2 = FeaturedStoreDataSource(
            [UIImage?](repeating: nil, count: 1),
            reuseIdentifier: "LoadingFeaturedCollectionCell") { (image, cell) -> UICollectionViewCell in
                cell.fadeInOut()
                
                return cell
        }
            
        self.featuredCollectionDataSource = dataSource2
        featuredFoodCollectionView.dataSource = dataSource2
        
        let dataSource3 = FeaturedStoreDataSource([UIImage?](repeating: nil, count: 1), reuseIdentifier: "LoadingHotDealCell") { (image, cell) -> UICollectionViewCell in
            cell.fadeInOut()
            
            return cell
        }
        self.hotDealsCollectionDataSource = dataSource3
        hotDealsCollectionView.dataSource = dataSource3
    }
    
    private func loadDynamicMockData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 0...10))) { [weak self] in
            self?.initFeaturedStore()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 0...10))) { [weak self] in
            self?.initFeaturedCollections()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 0...10))) { [weak self] in
            self?.initHotDeals()
        }
    }
    
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
        
        featuredStoresCollectionView.animate(with: dataSource)
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
                featuredCell.featuredImageView.cornerRadius = cell.frame.width / 2
            }
            
            return cell
        }
        
        self.featuredCollectionDataSource = dataSource
        
        featuredFoodCollectionView.animate(with: dataSource)
    }
    
    func initHotDeals() {
        let images : [(UIImage?,String,String)] = [
            (
                UIImage(named: "collection-cream"),
                "30% off!!! When you order Tomyam",
                "Fast Delivery"
            ),
            (
                UIImage(named: "food-bread"),
                "Vegan Delight 50% off",
                "Halal"
            ),
            (
                UIImage(named: "food-baked-goods"),
                "Baker's Heaven",
                "Promo!!!"
            )
        ]
        
        let dataSource = FeaturedStoreDataSource(images, reuseIdentifier: "HotDealCell") { (tuple, cell) -> UICollectionViewCell in
            if let featuredCell = cell as? HotDealCollectionCell {
                featuredCell.hotDealImageView.image = tuple.0
                featuredCell.promoLabel.text = tuple.1
                featuredCell.detailLabel.text = tuple.2
            }
            
            return cell
        }
        
        self.hotDealsCollectionDataSource = dataSource

        hotDealsCollectionView.animate(with: dataSource)
    }
}
