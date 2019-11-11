//
//  HotelListController.swift
//  CompositionalLayout
//
//  Created by Sushma Nayak on 08/11/19.
//  Copyright © 2019 Sushma Nayak. All rights reserved.
//

import Foundation


class HotelListController {

    var collections: [HotelCollection] {
        return _collections
    }

    init() {
        generateCollections()
    }
    
    fileprivate var _collections = [HotelCollection]()
}

extension HotelListController {
    func generateCollections() {
        _collections = [
            HotelCollection(title: "Featured",
                            hotels: [Hotel(title: "Moxy Berlin Hotel", rating: "★★★★★", price: "€120", imageURL: "4.jpg")]),

            HotelCollection(title: "Recently Viewed",
                            hotels: [Hotel(title: "Meliå Berlin", rating: "★★★", price: "€89", imageURL: "1.jpg"),
                                     Hotel(title: "Sheraton Berlin Hotel", rating: "★★★★", price: "€70", imageURL: "2.jpg"),
                                     Hotel(title: "Adlon kemps", rating: "★★", price: "€50", imageURL: "3.jpg"),
                                     Hotel(title: "H4 Berlin Hotel", rating: "★★★★", price: "€100", imageURL: "5.jpg"),
                                     Hotel(title: "Grand Hyatt", rating: "★★★★★", price: "€110", imageURL: "6.jpg")]),

            HotelCollection(title: "Related",
                            hotels: [Hotel(title: "Regent Berlin", rating: "★★★★★", price: "€89", imageURL: "7.jpg"),
                                     Hotel(title: "Hilton Berlin", rating: "★★★★★", price: "€70", imageURL: "8.jpg"),
                                     Hotel(title: "H2 hotel", rating: "★★", price: "€50", imageURL: "9.jpg"),
                                     Hotel(title: "Forld Hotel", rating: "★★★★", price: "€100", imageURL: "10.jpg"),
                                     Hotel(title: "Lux11", rating: "★★★★★", price: "€110", imageURL: "1.jpg")])
        ]
    }
}

struct Hotel: Hashable {
    let title: String
    let rating: String
    let price: String
    let imageURL: String
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

struct HotelCollection: Hashable {
    let title: String
    let hotels: [Hotel]

    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
