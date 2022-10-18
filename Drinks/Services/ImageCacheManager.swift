//
//  ImageCacheManager.swift
//  Drinks
//
//  Created by igor s on 06.09.2022.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
