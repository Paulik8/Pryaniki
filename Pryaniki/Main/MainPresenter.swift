//
//  MainPresenter.swift
//  Pryaniki
//
//  Created by Paulik on 14.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

class MainPresenter {
    
    weak var view: MainView?
    var mainService: MainService
    var currentList: [Datum]? {
        didSet {
            self.view?.showData()
        }
    }
    var mainModel: MainModel? {
        didSet {
            self.prepareFinishList()
        }
    }
    
    init() {
        self.mainService = MainService()
    }
    
    func attachView(_ view: MainView) {
        self.view = view
    }
    
    func loadData() {
        mainService.loadData {
            self.mainModel = $0
        }
    }
    
    func itemClicked(on index: Int) {
        guard let listData = currentList else { return }
        let item = listData[index]
        var message: String
        switch item.name {
        case .hz:
            guard let _text = item.data.text else { return }
            message = generateMessage(category: item.name.rawValue, name: _text)
        case .picture:
            guard let _text = item.data.text else { return }
            message = generateMessage(category: item.name.rawValue, name: _text)
        case .selector:
            guard let id = item.data.selectedID,
                let variants: [Variant] = item.data.variants else { return }
            message = generateMessage(category: item.name.rawValue, name: variants[id].text, id: id)
        }
        view?.showInfoItemClicked(message: message)
    }
    
    private func generateMessage(category: String, name: String, id: Int? = nil) -> String {
        if let _id = id {
           return "You tapped! Category: \(category), SelectedId: \(String(describing: _id)), Name: \(name)"
        } else {
            return "You tapped! Category: \(category), Name: \(name)"
        }
    }
    
    func prepareFinishList()  {
        guard let model = mainModel else { return }
        var orderedList: [Datum] = []
        model.view.forEach({ view in
            if let el = model.data.first(where: { view == $0.name} ) {
                orderedList.append(el)
            }
        })
        currentList = orderedList
    }
    
}
