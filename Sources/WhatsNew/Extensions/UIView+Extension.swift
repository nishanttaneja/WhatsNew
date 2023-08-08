//
//  UIView+Extension.swift
//  
//
//  Created by Nishant Taneja on 09/08/23.
//

import UIKit

extension UIView {
    func addSubview(_ subview: UIView, with insets: UIEdgeInsets) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: insets.top),
            subview.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: insets.left),
            subview.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -insets.right),
            subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
