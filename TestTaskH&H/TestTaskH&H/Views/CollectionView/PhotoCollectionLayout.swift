//
//  PhotoCollectionLayout.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 01.06.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionLayout: UICollectionViewLayout {
    
    // MARK: - publick props
    var delegate: CollectionLayoutDelegate?
    
    // MARK: - private props
    static var numberOfRow = 1
    private var cellPadding: CGFloat = 0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentWidth: CGFloat = 0
    
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let insents = collectionView.contentInset
        
        return collectionView.bounds.height - (insents.left + insents.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentWidth = 0
        cache = []
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate?.collectionView(collectionView, indexPath: indexPath)
            photos.append(photoSize ?? CGSize(width: 0, height: 0))
        }
        
        let superViewWidth = collectionView.frame.width
        let photosRelation = photos.map {$0.height / $0.width}
        
        guard var rowHeight = PhotoCollectionLayout.rowHeightCalculate(widthSuperView: superViewWidth, arrayPhotos: photos) else { return }
        
        rowHeight = rowHeight / CGFloat(PhotoCollectionLayout.numberOfRow)
        
        var yOffset = [CGFloat]()
        var xOffset = [CGFloat](repeating: 0, count: PhotoCollectionLayout.numberOfRow)
        
        
        for row in 0 ..< PhotoCollectionLayout.numberOfRow {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        
        var row = 0
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let ratio = photosRelation[indexPath.row]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] += width
            row = row < (PhotoCollectionLayout.numberOfRow - 1) ? (row + 1) : 0
        }
    }
    
    static func rowHeightCalculate(widthSuperView:CGFloat, arrayPhotos: [CGSize]) -> CGFloat? {
        var rowHeight:CGFloat
        
        let minRelation = arrayPhotos.min(by: { (firstPhoto, secondPhoto) -> Bool in
            (firstPhoto.height / firstPhoto.width) < (secondPhoto.height / secondPhoto.width)
        })
        
        guard let myMinRelation = minRelation else { return nil}
        let difference = widthSuperView / myMinRelation.width
        rowHeight = myMinRelation.height * difference
        rowHeight = rowHeight * CGFloat(PhotoCollectionLayout.numberOfRow)
        
        return rowHeight
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttribute = [UICollectionViewLayoutAttributes]()
        
        for attr in cache {
            if attr.frame.intersects(rect) {
                visibleAttribute.append(attr)
            }
        }
        
        return visibleAttribute
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
