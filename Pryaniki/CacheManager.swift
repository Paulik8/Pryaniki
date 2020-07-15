//
//  CacheManager.swift
//  Pryaniki
//
//  Created by Paulik on 15.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class CacheManager {
    
    static let shared: CacheManager = {
        let shared = CacheManager()
        return shared
    }()
    
    let cache = NSCache<NSString, UIImage>()
    
    func cacheImage(id: String, data: UIImage) {
        let nsId = id as NSString
        if let _ = cache.object(forKey: nsId) {
            return
        } else {
            cache.setObject(data, forKey: nsId)
        }
    }
    
    func getCachedImage(id: String) -> UIImage? {
        guard let data: UIImage = cache.object(forKey: id as NSString) else { return nil }
        return data
    }
    
}
