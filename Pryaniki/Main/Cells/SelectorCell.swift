//
//  SelectorCell.swift
//  Pryaniki
//
//  Created by Paulik on 15.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class SelectorCell: BaseCell {
    
    override var container: Card? {
        set {
            newValue?.translatesAutoresizingMaskIntoConstraints = false
            super.container = newValue
        }
        get {
            return super.container
        }
    }
    
    var text: CardText = {
        let text = CardText()
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.container = Card(frame: .zero, tag: MainModelViews.selector)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(text: String?) {
        self.text.text = text ?? ""
    }
    
    override func setupUi() {
        guard let container = container else { print("err"); return }
        super.setupUi()
        addSubview(text)
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            text.topAnchor.constraint(equalTo: container.topAnchor, constant: 16)
        ])
    }
    
}

