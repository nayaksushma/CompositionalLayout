//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Sushma Nayak on 08/11/19.
//  Copyright © 2019 Sushma Nayak. All rights reserved.
//

import UIKit

struct Constants {
    private init() {}
    static let titleElementKind = "title-element-kind"
}


class ViewController: UIViewController {

    enum Section: Int {
        case featured
        case recentlyViewed
        case related
    }
    
    let hotelList = HotelListController()
    var dataSource: UICollectionViewDiffableDataSource<HotelCollection, Hotel>! = nil
    var listCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Hotels"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        configureDataSource()
    }

    func configureCollectionView() {
        listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        listCollectionView.backgroundColor = .systemBackground
        view.addSubview(listCollectionView)
        NSLayoutConstraint.activate([
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        listCollectionView.register(HotelListCell.self, forCellWithReuseIdentifier: HotelListCell.reuseIdentifier)
        listCollectionView.register(HotelCollectionTitleView.self, forSupplementaryViewOfKind: Constants.titleElementKind, withReuseIdentifier: HotelCollectionTitleView.reuseIdentifier)
    }
}

//MARK: - Layout Creation.
extension ViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //Creating the item.
            let item = self.layoutItem(forSection: sectionIndex)
            
            //Creating the Group for the layout items.
            let group = self.layoutGroup(forSection: sectionIndex, layoutEnvironment: layoutEnvironment, item: item)
            
            //Creating the section.
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = (Section(rawValue: sectionIndex) == .featured) ? 0 : 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)

            //Creation of supplementary view. ie. Title Header view.
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: Constants.titleElementKind, alignment: .topLeading)
            section.boundarySupplementaryItems = [titleSupplementary]
            
            return section
        }
        
        //Additional configuration for the layout.
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
    
        //Layout creation.
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    
    func layoutItem(forSection section: Int) -> NSCollectionLayoutItem {
        let itemWidth = (Section(rawValue: section) == .related) ? CGFloat(0.4) : CGFloat(1.0)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    
    func layoutGroup(forSection section: Int, layoutEnvironment: NSCollectionLayoutEnvironment, item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let isHorizontal = layoutEnvironment.container.effectiveContentSize.width > 500
        let groupWidth = widthForGroup(inSection: section, forHorizontalLayout: isHorizontal)
        let groupHeight = heightForGroup(inSection: section, forHorizontalLayout: isHorizontal)
        let groupItemcount = (Section(rawValue: section) == .related) ? 2 :1
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: groupItemcount)
        group.interItemSpacing = .fixed(20)
        return group
    }
    
    private func widthForGroup(inSection section: Int, forHorizontalLayout isHorizontal:Bool) -> NSCollectionLayoutDimension {
        var width:NSCollectionLayoutDimension = .absolute(100)
        switch Section(rawValue: section) {
        case .featured:
            width = .fractionalWidth(CGFloat(isHorizontal ? 0.95 : 0.9))
        case .related:
            width = .fractionalWidth(CGFloat(isHorizontal ? 0.5 : 1.0))
        case .recentlyViewed:
            width = .fractionalWidth(CGFloat(isHorizontal ? 0.5 : 0.8))
        case .none:
            print("none case")
        }
        return width
    }
    
    private func heightForGroup(inSection section: Int, forHorizontalLayout isHorizontal:Bool) -> NSCollectionLayoutDimension {
        var height:NSCollectionLayoutDimension = .absolute(100)
        switch Section(rawValue: section) {
        case .featured:
            height = .fractionalHeight(CGFloat(isHorizontal ? 0.8 : 0.6))
        case .related:
            height = .absolute(200)
        case .recentlyViewed:
            height = .absolute(250)
        case .none:
            print("none case")
        }
        return height
    }
}

//MARK: - Datasource Configuration.
extension ViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<HotelCollection,Hotel> (collectionView: listCollectionView, cellProvider: { (collectionView, index, hotel) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HotelListCell.reuseIdentifier,
                for: index) as? HotelListCell
                else {
                    fatalError("Cannot create new cell")
                }
            
            cell.titleLabel.text = hotel.title
            cell.ratingLabel.text = hotel.rating
            cell.priceLabel.text = hotel.price
            cell.imageView.image = UIImage(named: hotel.imageURL)

            // Return the cell.
            return cell
            
        })
        // Datasource for supplementart view.
        dataSource.supplementaryViewProvider = { [weak self]
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self else { return nil }
            
            let currentSnapshot = self.snapshotForCurrentState()
            
            // Get a supplementary view of the desired kind.
            if let titleSupplementary = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HotelCollectionTitleView.reuseIdentifier,
                for: indexPath) as? HotelCollectionTitleView {

                // Populate the view with our section's description.
                let hotelCollection = currentSnapshot.sectionIdentifiers[indexPath.section]
                titleSupplementary.label.text = hotelCollection.title

                // Return the view.
                return titleSupplementary
            } else {
                fatalError("Cannot create new supplementary")
            }
        }
        
        let snapshot = snapshotForCurrentState()
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<HotelCollection, Hotel> {
          var snapshot = NSDiffableDataSourceSnapshot<HotelCollection, Hotel>()
          hotelList.collections.forEach {
              let collection = $0
              snapshot.appendSections([collection])
              snapshot.appendItems(collection.hotels)
          }
          return snapshot
      }

}
