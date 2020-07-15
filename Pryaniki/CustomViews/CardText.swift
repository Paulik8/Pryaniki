//
//  CardText.swift
//  Pryaniki
//
//  Created by Paulik on 15.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class CardText: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUi() {
        self.font = UIFont.systemFont(ofSize: 20)
        self.textColor = .darkGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
