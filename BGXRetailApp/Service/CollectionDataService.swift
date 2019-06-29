//
//  CollectionDataService.swift
//  BGXRetailApp
//
//  Created by Rolly Ceballos on 06/29/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

public protocol CollectionDataService {
    func fetchCollections(completion: @escaping ([StoreCollection]?) -> Void) -> Cancellable
}
