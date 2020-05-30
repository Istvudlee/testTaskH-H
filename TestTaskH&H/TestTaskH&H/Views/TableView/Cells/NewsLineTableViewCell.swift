//
//  NewsLineTableViewCell.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit
import Kingfisher

class NewsLineTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "lineCell"
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private let titleGroupLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold14
        label.textColor = AppColors.black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular13
        label.textColor = AppColors.blueGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postTextLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular14
        label.textColor = AppColors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    private let wrapDetailPostView = UIView()
    private let lineView = UIView()
    
    private var likeView = DetailPostView(image: .like)
    private var schareView = DetailPostView(image: .shared)
    private var commentView = DetailPostView(image: .comment)
    private var browseView = DetailPostView(image: .view)
    
    var data: NewsLineCellModel? {
        didSet {
            if let data = data {
                titleGroupLabel.text = data.name
                postTextLabel.text = data.text
                let url = URL(string: data.photo)
                logoImage.kf.setImage(with: url)
                postTextLabel.text = data.text
                likeView.setNumber(number: data.likes)
                schareView.setNumber(number: data.reposts)
                commentView.setNumber(number: data.reposts)
                browseView.setNumber(number: data.views)
                dataLabel.text = data.date
                print("RR\(data.photPost.count)")
                if !data.photPost.isEmpty {
                   postImageView.kf.setImage(with: URL(string: data.photPost[0] ))
                     postImageView.isHidden = false
                } else {
                    postImageView.isHidden = true
                }
               
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
        selectionStyle = .none
        
        addSubview(logoImage)
        addSubview(titleGroupLabel)
        addSubview(dataLabel)
        addSubview(postTextLabel)
        addSubview(postImageView)
        addSubview(wrapDetailPostView.prepareForAutoLayout())
        
        logoImage.leadingAnchor ~= leadingAnchor + 18
        logoImage.topAnchor ~= topAnchor + 15
        logoImage.widthAnchor ~= 40
        logoImage.heightAnchor ~= 40
        
        titleGroupLabel.leadingAnchor ~= logoImage.trailingAnchor + 12
        titleGroupLabel.topAnchor ~= logoImage.topAnchor
        titleGroupLabel.trailingAnchor ~= trailingAnchor - 10
        
        dataLabel.leadingAnchor ~=  titleGroupLabel.leadingAnchor
        dataLabel.topAnchor ~= titleGroupLabel.bottomAnchor + 5
        
        postTextLabel.topAnchor ~= dataLabel.bottomAnchor + 15
        postTextLabel.leadingAnchor ~= logoImage.leadingAnchor
        postTextLabel.trailingAnchor ~= trailingAnchor - 38
        
        postImageView.topAnchor ~= postTextLabel.bottomAnchor + 15
        postImageView.pinToSuperview([.left, .right])
        postImageView.heightAnchor ~= 274
        
        wrapDetailPostView.pinEdgesToSuperviewEdges(excluding: .top)
        wrapDetailPostView.topAnchor ~= postImageView.bottomAnchor
        wrapDetailPostView.heightAnchor ~= 46
        
        wrapDetailPostView.addSubview(likeView.prepareForAutoLayout())
        wrapDetailPostView.addSubview(commentView.prepareForAutoLayout())
        wrapDetailPostView.addSubview(schareView.prepareForAutoLayout())
        wrapDetailPostView.addSubview(browseView.prepareForAutoLayout())
        wrapDetailPostView.addSubview(lineView.prepareForAutoLayout())
        
        likeView.centerYAnchor ~= wrapDetailPostView.centerYAnchor
        likeView.leadingAnchor ~= wrapDetailPostView.leadingAnchor + 18
        
        commentView.centerYAnchor ~= wrapDetailPostView.centerYAnchor
        commentView.leadingAnchor ~= likeView.trailingAnchor + 24
        
        schareView.centerYAnchor ~= wrapDetailPostView.centerYAnchor
        schareView.leadingAnchor ~= commentView.trailingAnchor + 24
        
        browseView.centerYAnchor ~= wrapDetailPostView.centerYAnchor
        browseView.trailingAnchor ~= wrapDetailPostView.trailingAnchor - 18
        
        lineView.pinEdgesToSuperviewEdges(excluding: .top)
        lineView.backgroundColor = AppColors.veryLightBlue
        lineView.heightAnchor ~= 1
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
