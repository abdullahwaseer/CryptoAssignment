//
//  UIActivityIndicatorView.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 22/12/2022.
//

import UIKit

extension UIActivityIndicatorView {
    
    public static func setupImageLoadingAnimation(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: view,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: view,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        view.addConstraints([centerX, centerY])
        
        return activityIndicator
    }
}
