//
//  DetailPostView.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 26.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit

enum ImageDetailPost: String {
    case like = "icLike"
    case shared = "icShare"
    case view = "icEye"
    case comment = "icComment"
}

class DetailPostView: UIView {
    
    // MARK: - private props
    private var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular13
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColors.blueGrey
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(countLabel)
        
        iconImageView.pinEdgesToSuperviewEdges(excluding: .right)
        iconImageView.widthAnchor ~= 26
        iconImageView.heightAnchor ~= 26
        
        countLabel.leadingAnchor ~= iconImageView.trailingAnchor + 5
        countLabel.centerYAnchor ~= iconImageView.centerYAnchor
        countLabel.trailingAnchor ~= trailingAnchor
    }
    
    convenience init(image: ImageDetailPost) {
        self.init()
        iconImageView.image = UIImage(named: image.rawValue)
    }
    
    func setNumber(number: Int)  {
        countLabel.text = String(number)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
