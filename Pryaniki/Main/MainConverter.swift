//
//  MainConverter.swift
//  Pryaniki
//
//  Created by Paulik on 15.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

class MainConverter {
    
    func convertFromDto(_ model: MainModelDto) -> MainModel? {
        let newViews = model.view.map({ MainModelViews(rawValue: $0)! })
        let mainModel = MainModel(data: model.data, view: newViews)
        return mainModel
    }
    
}

enum MainModelViews: String, Codable {
    case hz,
    selector,
    picture
}
