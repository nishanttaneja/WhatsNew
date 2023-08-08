//
//  WNViewController.swift
//  
//
//  Created by Nishant Taneja on 09/08/23.
//

import UIKit

public protocol WNViewControllerDataSource: NSObjectProtocol {
    func itemsForWhatsNewViewController() -> [WNItem]
}
public protocol WNViewControllerDelegate: NSObjectProtocol {
    func whatsNewViewControllerDidSelectContinue()
}

public class WNViewController: UIViewController {
    // MARK: - Properties
    private let insets = UIEdgeInsets(top: 48, left: 32, bottom: 32, right: 32)
    private let continueButtonHeight: CGFloat = 44
    private let itemCellReuseIdentifier = "WhatsNewItemCell-SSWhatsNewViewController"
    private var items: [WNItem] = []
    public weak var dataSource: WNViewControllerDataSource? = nil {
        didSet {
            items = dataSource?.itemsForWhatsNewViewController() ?? []
            itemsCollectionView?.reloadSections(.init(integer: .zero))
        }
    }
    public weak var delegate: WNViewControllerDelegate?
    
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's New"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    private var itemsCollectionView: UICollectionView! = nil
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 11
        return button
    }()
    
    private func configContinueButton() {
        continueButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.whatsNewViewControllerDidSelectContinue()
            self?.dismiss(animated: true)
        }), for: .touchUpInside)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.heightAnchor.constraint(equalToConstant: continueButtonHeight).isActive = true
    }
    private func configConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(itemsCollectionView)
        view.addSubview(continueButton)
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: insets.left),
            titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -insets.right),
            // Items Collection
            itemsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: insets.top/2),
            itemsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            itemsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            // Continue Button
            continueButton.topAnchor.constraint(equalTo: itemsCollectionView.bottomAnchor, constant: insets.top/2),
            continueButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: insets.left),
            continueButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -insets.right),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
        ])
    }
    private func configViews() {
        view.backgroundColor = .systemBackground
        configItemsCollectionView()
        configContinueButton()
        configConstraints()
    }
    
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        isModalInPresentation = true
    }
}


// MARK: - ItemsCollectionView
extension WNViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func configItemsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = insets.bottom/2
        itemsCollectionView = .init(frame: .zero, collectionViewLayout: layout)
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        itemsCollectionView.allowsSelection = false
        itemsCollectionView.register(WNItemCell.self, forCellWithReuseIdentifier: itemCellReuseIdentifier)
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellReuseIdentifier, for: indexPath)
        guard let itemCell = cell as? WNItemCell, indexPath.item < items.count else { return cell }
        itemCell.update(using: items[indexPath.item])
        return itemCell
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: WNItemCell.preferredHeight)
    }
}
