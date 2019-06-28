//
//  ViewController.swift
//  BGXRetailApp
//
//  Created by Rolly on 06/21/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree

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

// MARK: BrainTree Integration
extension ViewController {
    @IBAction func checkout() {
        let request = BTDropInRequest()
        
        let dropin = BTDropInController(authorization: clientToken, request: request) { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropin!, animated: true, completion: nil)
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
    
    // MARK: Mock Data Initialization

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

let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSjkuZXlKbGVIQWlPakUxTmpFME1qUTJOVFFzSW1wMGFTSTZJbVkxTURFeU5tRmlMVFJqT1dNdE5EbGpaaTFoTnpjM0xXSTRPR0kyTnpsaVpEaGhNaUlzSW5OMVlpSTZJak0wT0hCck9XTm5aak5pWjNsM01tSWlMQ0pwYzNNaU9pSkJkWFJvZVNJc0ltMWxjbU5vWVc1MElqcDdJbkIxWW14cFkxOXBaQ0k2SWpNME9IQnJPV05uWmpOaVozbDNNbUlpTENKMlpYSnBabmxmWTJGeVpGOWllVjlrWldaaGRXeDBJanBtWVd4elpYMHNJbkpwWjJoMGN5STZXeUp0WVc1aFoyVmZkbUYxYkhRaVhTd2liM0IwYVc5dWN5STZlMzE5LmZhREhPT2RSSzhrODVZZWc5ZUprNWk2S2JZNlF5RG04R0doeUstbmNXUmZjQmZvY0pjU1AtZVlqc0lpS21XYlN6UzEtcUxqVnNpdjdZMXRZNDlseUpnIiwiY29uZmlnVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaS92MS9jb25maWd1cmF0aW9uIiwiZ3JhcGhRTCI6eyJ1cmwiOiJodHRwczovL3BheW1lbnRzLnNhbmRib3guYnJhaW50cmVlLWFwaS5jb20vZ3JhcGhxbCIsImRhdGUiOiIyMDE4LTA1LTA4In0sImNoYWxsZW5nZXMiOltdLCJlbnZpcm9ubWVudCI6InNhbmRib3giLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9vcmlnaW4tYW5hbHl0aWNzLXNhbmQuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS8zNDhwazljZ2YzYmd5dzJiIn0sInRocmVlRFNlY3VyZUVuYWJsZWQiOnRydWUsInBheXBhbEVuYWJsZWQiOnRydWUsInBheXBhbCI6eyJkaXNwbGF5TmFtZSI6IkFjbWUgV2lkZ2V0cywgTHRkLiAoU2FuZGJveCkiLCJjbGllbnRJZCI6bnVsbCwicHJpdmFjeVVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS9wcCIsInVzZXJBZ3JlZW1lbnRVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vdG9zIiwiYmFzZVVybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9jaGVja291dC5wYXlwYWwuY29tIiwiZGlyZWN0QmFzZVVybCI6bnVsbCwiYWxsb3dIdHRwIjp0cnVlLCJlbnZpcm9ubWVudE5vTmV0d29yayI6dHJ1ZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwibWVyY2hhbnRBY2NvdW50SWQiOiJhY21ld2lkZ2V0c2x0ZHNhbmRib3giLCJjdXJyZW5jeUlzb0NvZGUiOiJVU0QifSwibWVyY2hhbnRJZCI6IjM0OHBrOWNnZjNiZ3l3MmIiLCJ2ZW5tbyI6Im9mZiJ9"
