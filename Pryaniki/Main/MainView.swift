//
//  MainView.swift
//  Pryaniki
//
//  Created by Paulik on 14.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenter?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setupUi()
        presenter = MainPresenter()
        presenter?.attachView(self)
        presenter?.loadData()
    }
    
    private func registerCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PictureCell
            .self, forCellWithReuseIdentifier: Constants.pictureCellIdentifier)
        collectionView.register(HzCell
                   .self, forCellWithReuseIdentifier: Constants.hzCellIdentifier)
        collectionView.register(SelectorCell
                   .self, forCellWithReuseIdentifier: Constants.selectorCellIdentifier)
    }
    
    private func setupUi() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func resolveCells(for model: [Datum], indexPath: IndexPath) -> UICollectionViewCell? {
        let index = indexPath.row
        let item = model[index]
        let tag = item.name
        var cell: UICollectionViewCell
        switch tag {
        case .picture:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.pictureCellIdentifier, for: indexPath)
            (cell as? PictureCell)?.updateData(text: item.data.text, imageUrl: item.data.url)
            return cell
        case .hz:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.hzCellIdentifier, for: indexPath)
            (cell as? HzCell)?.updateData(text: item.data.text)
            return cell
        case .selector:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.selectorCellIdentifier, for: indexPath)
            guard let selectedId = item.data.selectedID,
                let variants = item.data.variants else { return nil }
            let variant = variants[selectedId]
            (cell as? SelectorCell)?.updateData(text: variant.text)
            return cell
        }
        
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentList = presenter?.currentList else { return 0 }
        return currentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = presenter?.currentList else { fatalError("Logic error") }
        guard let cell = resolveCells(for: data, indexPath: indexPath) else { fatalError("New view type") }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.itemClicked(on: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let referenceHeight: CGFloat = 200
        let referenceWidth: CGFloat = UIScreen.main.bounds.size.width - collectionView.layoutMargins.left - collectionView.layoutMargins.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
}

extension MainViewController: MainView {
    
    func showData() {
        self.collectionView.reloadData()
    }
    
    func showInfoItemClicked(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tap", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
