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
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.topAnchor ~= topAnchor
        imageView.leadingAnchor ~= leadingAnchor
        imageView.widthAnchor ~= 200
        imageView.heightAnchor ~= 200
        backgroundColor = .red
        addPhoto(urlImage: "https://yandex.ru/search/?text=%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8&lr=42&clid=1222110")
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
