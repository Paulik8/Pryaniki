//
//  Card.swift
//  Pryaniki
//
//  Created by Paulik on 15.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class Card: UIView {
    
    private var tagCard: MainModelViews
    
    var parent: UIView = {
        let parent = UIView()
        parent.layer.shadowColor = UIColor.darkGray.cgColor
        parent.layer.shadowOpacity = 0.8
        parent.layer.shadowOffset = CGSize(width: 6, height: 6)
        parent.layer.shadowRadius = 8
        parent.layer.borderColor = UIColor.lightGray.cgColor
        parent.layer.borderWidth = 0.8
        parent.layer.cornerRadius = 40
        parent.translatesAutoresizingMaskIntoConstraints = false
        return parent
    }()
    
    init(frame: CGRect, tag: MainModelViews) {
        self.tagCard = tag
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUi() {
        addSubview(parent)
        NSLayoutConstraint.activate([
            parent.leadingAnchor.constraint(equalTo: leadingAnchor),
            parent.topAnchor.constraint(equalTo: topAnchor),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        if let layers = parent.layer.sublayers {
            if (!layers.contains(where: { $0.name == "bezier" })) {
               addSublayer()
            }
        } else {
            addSublayer()
        }
    }
    
    private func addSublayer() {
        var gradientColors: [CGColor]
        switch tagCard {
        case .hz:
            gradientColors = Colors.hzColors
        case .picture:
            gradientColors = Colors.pictureColors
        case .selector:
            gradientColors = Colors.selectorColors
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "bezier"
        let height = frame.height
        let initHeight = height / 2
        shapeLayer.path = createBezier(from: frame.size, initHeight: initHeight).cgPath
        let position = CGPoint(x: 0, y: initHeight)
        shapeLayer.position = position
        let gradient = CAGradientLayer()
        gradient.position = CGPoint(x: 0, y: 0)
        gradient.frame.size = frame.size
        gradient.colors = gradientColors
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = 40
        gradient.mask = shapeLayer
        parent.layer.addSublayer(gradient)
    }
    
    private func createBezier(from frame: CGSize, initHeight: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        let controlPoint1X = frame.width / 2.5
        let controlPoint2X = frame.width - frame.width / 7
        let curvePoint = CGPoint(x: frame.width / 1.5, y: frame.height / 3)
        let controlPoint1 = CGPoint(x: controlPoint1X, y: frame.height / 12)
        let controlPoint2 = CGPoint(x: controlPoint1X, y: frame.height / 3)
        path.addCurve(to: curvePoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        let curvePoint2 = CGPoint(x: frame.width, y: frame.height / 4)
        let controlPoint3 = CGPoint(x: controlPoint2X, y: frame.height / 3.5)
        let controlPoint4 = CGPoint(x: controlPoint2X, y: frame.height / 4)
        path.addCurve(to: curvePoint2, controlPoint1: controlPoint3, controlPoint2: controlPoint4)
        path.addLine(to: CGPoint(x: frame.width, y: initHeight))
        path.addLine(to: CGPoint(x: 0, y: initHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        return path
    }
    
}
