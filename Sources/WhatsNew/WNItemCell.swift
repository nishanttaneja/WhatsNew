//
//  WNItemCell.swift
//  
//
//  Created by Nishant Taneja on 09/08/23.
//

import UIKit

final class WNItemCell: UICollectionViewCell {
    // MARK: - Properties
    static var preferredHeight: CGFloat {
        WNItemDescriptionView.imageViewHeight
    }
    
    
    // MARK: - Views
    private let itemDescriptionView = WNItemDescriptionView()
    
    func update(using item: WNItem) {
        itemDescriptionView.set(image: item.image, title: item.title, description: item.description)
    }
    
    
    // MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemDescriptionView, with: .init(top: .zero, left: 32, bottom: .zero, right: 32))
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

