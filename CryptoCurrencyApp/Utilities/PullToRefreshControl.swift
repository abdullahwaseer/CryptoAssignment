//
//  PullToRefreshControl.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import UIKit


class PullToRefreshControl: UIRefreshControl {
    
    var didRefresh: (() -> Void)?
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.height, height: frame.height))
        view.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    convenience init(handler: @escaping () -> Void) {
        self.init()
        self.didRefresh = handler
        self.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }
    
    func programaticallyBeginRefreshing(in tableView: UITableView) {
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
        
        self.beginRefreshing()
    }
    
    @objc func onRefresh(_ sender: Any) {
        didRefresh?()
    }
}

extension PullToRefreshControl {
    
    private func prepareAnimationView() {
        containerView.center = center
        insertSubview(containerView, at: 0)
    }
}

extension UITableView {
    
    func add(_ refreshControl: PullToRefreshControl) {
        self.refreshControl = refreshControl
    }
}
