//
//  ActivityIndicator.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import UIKit

final class ActivityIndicator {
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        view.backgroundColor = .init(white: 0.4, alpha: 0.8)
        view.layer.cornerRadius = 10
        
        let activityIndicator = UIActivityIndicatorView.setupImageLoadingAnimation(in: view)
        activityIndicator.color = .white
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .init(white: 0.25, alpha: 0.25)
        
        contentView.center = view.center
        view.addSubview(contentView)

        return view
    }()
}

extension ActivityIndicator {
    
    public func startAnimation() {
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    public func stopAnimation() {
        self.containerView.removeFromSuperview()
    }
}
