//
//  Client.swift
//  BGXRetailApp
//
//  Created by Rolly Ceballos on 06/28/2019.
//  Copyright © 2019 Beagleworx Labs. All rights reserved.
//

import Foundation
import MobileBuySDK

extension URLSessionTask: Cancellable { }

final class Client: CollectionDataService {
    
    static let shopDomain = "graphql.myshopify.com"
    static let apiKey     = "8e2fef6daed4b93cf4e731f580799dd1"
    static let merchantID = "merchant.com.your.id"
    
    static let maxImageDimension = Int32(UIScreen.main.bounds.width)
    
    static let shared = Client()
    
    private let client: Graph.Client = Graph.Client(shopDomain: Client.shopDomain, apiKey: Client.apiKey)
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.client.cachePolicy = .cacheFirst(expireIn: 3600)
    }
    
    @discardableResult
    func fetchCollections(completion: @escaping ([StoreCollection]?) -> Void) -> Cancellable {
        let query = Storefront.buildQuery { $0
            .collections(first: Int32(30), after: nil) { $0
                .pageInfo { $0
                    .hasNextPage()
                }
                .edges { $0
                    .cursor()
                    .node { $0
                        .id()
                        .title()
                        .descriptionHtml()
                        .image(maxWidth: Client.maxImageDimension, maxHeight: Client.maxImageDimension) { $0
                            .transformedSrc()
                        }
                        
                        .products(first: Int32(1), after: nil) { $0
                            .fragmentForStandardProduct()
                        }
                    }
                }
            }
        }
        
        let task = client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            guard let query = query else {
                print("Failed to load collections")
                completion(nil)
                return
            }
            
            let collections = query.collections.edges.compactMap {
                return StoreCollection($0)
            }
            
            completion(collections)
        }
        
        task.resume()
        return GraphTask(task)
    }
}

// ----------------------------------
//  MARK: - GraphError -
//
extension Optional where Wrapped == Graph.QueryError {
    
    func debugPrint() {
        switch self {
        case .some(let value):
            print("Graph.QueryError: \(value)")
        case .none:
            break
        }
    }
}

internal class GraphTask<Base> {
    private let base : Base
    public init(_ base:Base) {
        self.base = base
    }
}

extension GraphTask: Cancellable where Base == Task {
    func cancel() {
        base.cancel()
    }
}

// MARK: StoreCollection Conversion

extension StoreCollection {
    init(_ edge:Storefront.CollectionEdge) {
        self.id             = edge.node.id.rawValue
        self.description    = edge.node.descriptionHtml
        self.imageUrl       = edge.node.image?.transformedSrc
    }
}

