//
//  NewsLineTableViewCell.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit

class NewsLineTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "lineCell"
    
    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "esquire"))
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        
        return image
    }()
    
    private let titleGroupLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold14
        label.textColor = AppColors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-squire"
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular13
        label.textColor = AppColors.blueGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "21.21.43"
        return label
    }()
    
    private let postTextLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular14
        label.textColor = AppColors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var data: NewsLineItem? {
        didSet {
            if let data = data {
                postTextLabel.text = data.text
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imgTableCell.image = nil
    }
    
    // MARK: - private method
    private func configureUI() {
        backgroundColor = AppColors.white
        selectionStyle = .default
        
        addSubview(logoImage)
        addSubview(titleGroupLabel)
        addSubview(dataLabel)
        addSubview(postTextLabel)
        
        logoImage.leadingAnchor ~= leadingAnchor + 18
        logoImage.topAnchor ~= topAnchor + 15
        logoImage.widthAnchor ~= 40
        logoImage.heightAnchor ~= 40
        
        titleGroupLabel.leadingAnchor ~= logoImage.trailingAnchor + 12
        titleGroupLabel.topAnchor ~= logoImage.topAnchor
        
        dataLabel.leadingAnchor ~=  titleGroupLabel.leadingAnchor
        dataLabel.topAnchor ~= titleGroupLabel.bottomAnchor + 5
        
        postTextLabel.topAnchor ~= logoImage.bottomAnchor + 15
        postTextLabel.leadingAnchor ~= logoImage.leadingAnchor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
