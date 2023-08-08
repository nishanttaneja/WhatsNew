//
//  WNItemDescriptionView.swift
//  
//
//  Created by Nishant Taneja on 09/08/23.
//

import UIKit

final class WNItemDescriptionView: UIView {
    // MARK: - Properties
    static let imageViewHeight: CGFloat = 68
    
    
    // MARK: - Views
    let imageView = UIImageView()
    let titleLabel = UILabel(font: .systemFont(ofSize: 14, weight: .semibold))
    let descriptionLabel = UILabel(font: .systemFont(ofSize: 14, weight: .light), numberOfLines: 3, textColor: .secondaryLabel)
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, UIView()])
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView])
        stackView.spacing = 16
        return stackView
    }()

    private func configImageView() {
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Self.imageViewHeight).isActive = true
    }
    private func configContentStackView() {
        addSubview(contentStackView, with: .zero)
    }
    
    func set(image: UIImage, title: String, description: String) {
        imageView.image = image.applyingSymbolConfiguration(.init(pointSize: 44))
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    
    // MARK: - Constructors
    required init(image: UIImage, title: String, description: String) {
        super.init(frame: .zero)
        configImageView()
        configContentStackView()
        set(image: image, title: title, description: description)
    }
    required init() {
        super.init(frame: .zero)
        configImageView()
        configContentStackView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

