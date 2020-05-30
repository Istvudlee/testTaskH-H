//
//  PhotoNewsCollectionView.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 30.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit

class PhotoNewsCollectionView: UICollectionView {

     init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(PhotoNewsCollectionViewCell.self, forCellWithReuseIdentifier: PhotoNewsCollectionViewCell.reuseIdentifier)
    }
    
    
    // MARK: - private props
    private func configureUI() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PhotoNewsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoNewsCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
