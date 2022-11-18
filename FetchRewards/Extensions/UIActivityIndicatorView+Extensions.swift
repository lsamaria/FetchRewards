//
//  UIActivityIndicatorView+Extensions.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

extension UIActivityIndicatorView {
    
    static func createActivityIndicatorView() -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .lightGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
}
