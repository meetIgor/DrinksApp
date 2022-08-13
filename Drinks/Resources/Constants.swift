//
//  Constants.swift
//  Drinks
//
//  Created by igor s on 13.08.2022.
//

import UIKit

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (
        UIScreen.main.bounds.width
        - Constants.leftDistanceToView
        - Constants.rightDistanceToView
        - (Constants.galleryMinimumLineSpacing / 2)
    ) / 2
    static let ingredietnsGalleryItemWidth = (
        UIScreen.main.bounds.width
        - Constants.leftDistanceToView
        - Constants.rightDistanceToView
        - (Constants.galleryMinimumLineSpacing / 3)
    ) / 3
}
