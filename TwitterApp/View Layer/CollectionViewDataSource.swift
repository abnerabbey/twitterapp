//
//  CollectionViewDataSource.swift
//  TwitterApp
//
//  Created by Abner Castro on 24/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource<CellType: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    
    let cellIdentifier: String
    var items: Int
    let configureCell: (CellType, IndexPath) -> ()
    
    init(cellIdentifier: String, items: Int, configureCell: @escaping (CellType, IndexPath) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CellType else { return UICollectionViewCell() }
        configureCell(cell, indexPath)
        return cell
    }
    
}
