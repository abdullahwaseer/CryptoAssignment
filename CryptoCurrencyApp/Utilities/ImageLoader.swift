//
//  ImageLoader.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 22/12/2022.
//

import Foundation
import UIKit

actor ImageLoader {
    
    public static let shared = ImageLoader()
    
    /// Set NSString here as key to cache the images, because NSCache needs the class type
    private let cachedImages = NSCache<NSString, UIImage>()
    
    /// Get cached image already downloaded
    private func image(key: NSString) -> UIImage? {
        return cachedImages.object(forKey: key)
    }
    
    /// Add image to cache just downloaded
    private func setImage(_ image: UIImage, for key: NSString, bytes: Int) {
        cachedImages.setObject(image, forKey: key, cost: bytes)
    }
    
    /// Returns the cached image if available, otherwise asynchronously loads and caches it, using async await (New Released Swift Feature)
    public func load(from url: URL) async -> UIImage? {
        let urlKey = NSString(url)
        
        if let cachedImage = image(key: urlKey) {
            return cachedImage
        }
        
        let task: Task<UIImage?, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: imageData) else { return nil }
            
            self.setImage(image, for: urlKey, bytes: imageData.count)
            return image
        }
        
        do {
            let image = try await task.value
            return image
        } catch {
            return nil
        }
    }
}

fileprivate extension NSString {
    convenience init(_ url: URL) {
        self.init(string: url.absoluteString)
    }
}
