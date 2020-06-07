//
//  PhotoNewsCollectionViewCell.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 30.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoNewsCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = "photoCell"
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.pinEdgesToSuperviewEdges(top: 4, left: 0, right: 4, bottom: 4)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }

    func addPhoto(urlImage: String) {
        imageView.kf.setImage(with: URL(string: urlImage))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
