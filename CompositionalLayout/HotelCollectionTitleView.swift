//
//  HotelCollectionTitleView.swift
//  CompositionalLayout
//
//  Created by Sushma Nayak on 09/11/19.
//  Copyright © 2019 Sushma Nayak. All rights reserved.
//

import Foundation
import UIKit

class HotelCollectionTitleView: UICollectionReusableView {
    let label = UILabel()
    static let reuseIdentifier = "collectionTitleView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HotelCollectionTitleView {
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        label.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
