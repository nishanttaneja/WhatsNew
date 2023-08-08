//
//  WNItem.swift
//  
//
//  Created by Nishant Taneja on 09/08/23.
//

import UIKit

public struct WNItem {
    let image: UIImage
    let title: String
    let description: String
    
    public init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
}
