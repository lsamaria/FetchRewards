//
//  TextView+Extensions.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

extension UITextView {
    
    static func createTextView(textColor: UIColor) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = textColor
        textView.isEditable = false
        return textView
    }
}
