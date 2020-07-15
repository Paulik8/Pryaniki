//
//  MainService.swift
//  Pryaniki
//
//  Created by Paulik on 14.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

class MainService {
    
    var converter: MainConverter
    
    init() {
        self.converter = MainConverter()
    }
    
    func loadData(_ completion: @escaping (MainModel) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = URL(string: Constants.mainDataUrl) else { return }
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(MainModel.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch (let error) {
                print(error)
            }
        }
    }
    
}
