//
//  UIImageView.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 22/12/2022.
//

import UIKit

extension UIImageView {
    
    func setImage(from url: URL?, placeholderImage: UIImage?) {
        guard let url = url else {
            self.image = placeholderImage
            return
        }
        
        let activityIndicator = UIActivityIndicatorView.setupImageLoadingAnimation(in: self)
        Task {
            let image = await ImageLoader.shared.load(from: url)
            activityIndicator.stopAnimating()
            
            if let image = image {
                self.image = image
            }
            else {
                self.image = placeholderImage
            }
        }
    }
}

