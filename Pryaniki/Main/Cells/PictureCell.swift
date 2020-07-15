//
//  PictureCell.swift
//  Pryaniki
//
//  Created by Paulik on 14.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class PictureCell: BaseCell {
    
    override var container: Card? {
        set {
            newValue?.translatesAutoresizingMaskIntoConstraints = false
            super.container = newValue
        }
        get {
            return super.container
        } 
    }
    
    var imageUrl: String? {
        didSet {
            guard let imageString = imageUrl else { return }
            guard let url = URL(string: imageString) else { return }
            loadImage(from: url)
        }
    }
    
    var image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 140))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var text: CardText = {
        let text = CardText()
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.container = Card(frame: .zero, tag: MainModelViews.picture)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(text: String?, imageUrl: String?) {
        self.text.text = text
        self.imageUrl = imageUrl
    }
    
    override func setupUi() {
        guard let container = container else { print("err"); return }
        super.setupUi()
        addSubview(image)
        addSubview(text)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            image.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -12),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            text.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            text.topAnchor.constraint(equalTo: image.topAnchor)
        ])
    }
    
    private func loadImage(from url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageUrl = self.imageUrl else { return }
            if let _image = CacheManager.shared.getCachedImage(id: imageUrl) {
                self.setImage(for: url, image: _image)
            } else {
                guard let data = try? Data(contentsOf: url) else { return }
                self.setImage(for: url, data: data)
            }
        }
    }
    
    private func setImage(for url: URL, data: Data? = nil, image: UIImage? = nil) {
        DispatchQueue.main.async {
            guard let imageString = self.imageUrl else { return }
            if url.absoluteString == imageString {
                if let _image = image {
                    self.image.image = _image
                } else {
                    guard let _data = data,
                        let convertedImage = UIImage(data: _data) else { return }
                    CacheManager.shared.cacheImage(id: imageString, data: convertedImage)
                    self.image.image = convertedImage
                }
            }
        }
    }
    
}

