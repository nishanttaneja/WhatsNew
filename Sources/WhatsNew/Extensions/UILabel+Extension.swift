//
//  UILabel+Extension.swift
//  
//
//  Created by Nishant Taneja on 09/08/23.
//

import UIKit

extension UILabel {
    convenience init(title: String? = nil, font: UIFont, numberOfLines: Int = 1, textColor: UIColor = .label) {
        self.init()
        text = title
        self.font = font
        self.numberOfLines = numberOfLines
        self.textColor = textColor
    }
}
