//
//  BaseCell.swift
//  Pryaniki
//
//  Created by Paulik on 15.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    var container: Card?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUi() {
        guard let container = container else { return }
        addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
