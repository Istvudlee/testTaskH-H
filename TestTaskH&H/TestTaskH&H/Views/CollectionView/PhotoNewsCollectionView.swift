//
//  PhotoNewsCollectionView.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 30.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit

class PhotoNewsCollectionView: UICollectionView {
    
    var dataPhoto: [PhotosPostForCellModel]? {
        didSet {
            self.reloadData()
            contentOffset = CGPoint.zero
        }
    }

     init() {
        let photoLayout = PhotoCollectionLayout()
        super.init(frame: .zero, collectionViewLayout: photoLayout)
        delegate = self
        dataSource = self
        register(PhotoNewsCollectionViewCell.self, forCellWithReuseIdentifier: PhotoNewsCollectionViewCell.reuseIdentifier)
        backgroundColor = AppColors.white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        if let photoLayout = collectionViewLayout as? PhotoCollectionLayout {
            photoLayout.delegate = self
        }
    }
    
    
    // MARK: - private props
    private func configureUI() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PhotoNewsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPhoto?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoNewsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.addPhoto(urlImage: dataPhoto?[indexPath.row].url ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

extension PhotoNewsCollectionView: CollectionLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        
        guard let photo = dataPhoto else { return CGSize(width: 0, height: 0)}
        let width = photo[indexPath.row].width
        let height = photo[indexPath.row].height
        
        return CGSize(width: width, height: height)
    }
    
    
}
