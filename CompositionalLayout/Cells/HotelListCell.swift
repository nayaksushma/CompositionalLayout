//
//  HotelListCell.swift
//  CompositionalLayout
//
//  Created by Sushma Nayak on 08/11/19.
//  Copyright © 2019 Sushma Nayak. All rights reserved.
//

import UIKit

class HotelListCell: UICollectionViewCell {

    static let reuseIdentifier = "hotelListCell"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let ratingLabel = UILabel()
    let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}


extension HotelListCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel)
        

        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        ratingLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        ratingLabel.adjustsFontForContentSizeCategory = true
        ratingLabel.textColor = .systemRed
        ratingLabel.textAlignment = .left
        
        priceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.textColor = .systemBlue
        priceLabel.textAlignment = .right

        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        let spacing = CGFloat(8)
        let spacing2 = CGFloat(5)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),

            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,  constant: spacing2),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,  constant: spacing2),
            priceLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
}

