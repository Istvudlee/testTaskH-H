//
//  CollectionLayoutDelegate.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 06.06.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
}
