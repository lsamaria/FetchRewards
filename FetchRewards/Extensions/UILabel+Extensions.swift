//
//  UILabel+Extensions.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

extension UILabel {
    
    static func createLabel(font: UIFont, textColor: UIColor = .black, numOfLines: Int = 0, textAlignment: NSTextAlignment = .left) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numOfLines
        label.sizeToFit()
        return label
    }
}
