//
//  ImageView+Extensions.swift
//  GithubDM
//
//  Created by Rolly Ceballos on 11/11/2018.
//  Copyright © 2018 Beagleworx Labs. All rights reserved.
//

import UIKit

/// An extension to provide for asynchronous image loading from a web resource
public protocol ImageCacheExtension {
    associatedtype CacheExtensionType
    var iae : CacheExtensionType { get }
}

/// Provides for a computed property
public extension ImageCacheExtension {
    var iae : ImageCache<Self> {
        return ImageCache(self)
    }
}

/// Adds extension to UIImageView
extension UIImageView : ImageCacheExtension { }

/// Provides extended/computed property for ImageCacheExtension
public final class ImageCache<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// Global Image Cache
// TODO: Provide a more robust API for using this cache
let imageCache = NSCache<AnyObject, AnyObject>()

/// Associated urlKey
private var urlKey: Void?

/// Extension methods declaration
extension ImageCache where Base : UIImageView {
    public typealias LazyImageHandler = (UIImage?,Error?,URL?) ->Void
    
    /// Convenience function for getting image from URL
    /// - Parameter url: A valid URL instance for the image
    /// - Parameter completionHandler: A block to execute event after asynchronous etch is complete
    public func setImage(from url:URL, placeHolder : UIImage?, completionHandler:LazyImageHandler?) -> Cancellable? {
        self.base.image = placeHolder
        
        return fetchImage(url:url) { [weak base] (image, error, url) in
            guard let strongBase = base, let image = image, let imageUrl = url, self.imageURL == imageUrl.absoluteString else {
                completionHandler?(nil,error,url)
                return
            }
            
            strongBase.image = image
            
            completionHandler?(image,error,imageUrl)
        }
    }
    
    /// Convenience function for getting image from web URL string
    /// - Parameters:
    ///     - urlString: A valid web URL of the image
    ///     - completionHandler: A block to execute event after asynchronous fetch is complete
    public func setImage(from urlString:String, completionHandler: LazyImageHandler?) -> Cancellable? {
        return setImage(from: urlString, placeHolder: nil, completionHandler: completionHandler)
    }
    
    /// Convenience function for getting image from web URL
    /// - Parameters:
    ///     - urlString: A valid web URL of the image
    ///     - placeHolder: A temporary placeholder **UIImage**
    ///     - completionHandler: A block to execute event after asynchronous fetch is complete
    @discardableResult
    public func setImage(from urlString:String, placeHolder : UIImage?, completionHandler: LazyImageHandler?) -> Cancellable? {
        /// Download the image asynchronously
        self.base.image = placeHolder
        
        guard let url = URL(string: urlString) else {
            /// Remember the URL for this instance
            setImageURL(nil)
            
            // TODO: Add error instance here
            completionHandler?(nil,nil,nil)
            return nil
        }

        return setImage(from: url, placeHolder: placeHolder, completionHandler: completionHandler)
    }
    
    /// Helper function to fetch image from remote URL, and store in cache
    /// - Parameters:
    ///     - urlString: Remote URL of the image
    ///     - completionHandler: A block to execute event after asynchronous fetch is complete
    /// - Returns: An instance of **URLSessionDataTask** running the asynchronous fetch, or nil if it fails
    @discardableResult
    func fetchImage(url: URL, completionHandler:LazyImageHandler?) -> URLSessionDataTask? {
        let imageURLString = url.absoluteString
        /// Remember the URL for this instance
        setImageURL(imageURLString)

        if let imageFromCache = imageCache.object(forKey: imageURLString as AnyObject) as? UIImage {
            completionHandler?(imageFromCache,nil,url)
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data, let imageToCache = UIImage(data: response) {
                DispatchQueue.main.async {
                    imageCache.setObject(imageToCache, forKey: imageURLString as AnyObject)
                    completionHandler?(imageToCache,error,url)
                }
            } else {
                completionHandler?(nil,error,url)
            }
        }
        
        task.resume()
        
        return task
    }
    
    /// Computed property for imageURL of this **UIImageView** instance
    /// Helpful for reusable instance in Collection Views
    /// - Returns: The latest URL associated with this **UIImageView** instance
    public var imageURL : String? {
        return objc_getAssociatedObject(base, &urlKey) as? String
    }
    
    /// Updates the imageURL associated with this **UIImageView** instance
    /// - Parameters:
    ///     - urlString: The remote URL for the image
    private func setImageURL(_ urlString : String?) {
        objc_setAssociatedObject(base, &urlKey, urlString, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
