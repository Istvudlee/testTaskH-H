//
//  CalculateCellSize.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 30.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import UIKit

struct Size: CellSizesProtocol {
    var fullHeight: CGFloat
    var textFrame: CGRect
    var imageFrame: CGRect
}

struct ConstansSizeCell {
    static let postTextInsents = UIEdgeInsets(top: 30 + topViewHeight, left: 18, bottom: 15, right: 18)
    static let topViewHeight: CGFloat = 40
    static let font = AppFonts.regular14
    static let bottomViewHeight: CGFloat = 46
}

class CalculateCellSize {
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    func getSize(_ text: String?, images: [PhotosPostForCellModel]?) -> CellSizesProtocol {
        
        // frame text
        var postTextFrame = CGRect(origin: CGPoint(x: ConstansSizeCell.postTextInsents.left, y: ConstansSizeCell.postTextInsents.top),size: CGSize.zero)
        
        if let postText = text, !postText.isEmpty {
            let width = screenWidth - ConstansSizeCell.postTextInsents.left - ConstansSizeCell.postTextInsents.right
            let height = calculateTextHeight(width: width, font: ConstansSizeCell.font, text: postText)
            
            postTextFrame.size = CGSize(width: width, height: height)
        }
        
        // frame image
        let topImagePoint = postTextFrame.size == CGSize.zero ? ConstansSizeCell.postTextInsents.top : postTextFrame.maxY + ConstansSizeCell.postTextInsents.bottom
        
        var imageFrame = CGRect(origin: CGPoint(x: 0, y: topImagePoint), size: CGSize.zero)
        
        if let postImage = images?.first {
            let relation = calculateRelation(width: postImage.width, height: postImage.height)
            if images?.count == 1 {
                 imageFrame.size = CGSize(width: screenWidth, height: CGFloat(screenWidth * relation))
            }
        }
        
        // bottom frame
        let bottonTop = max(postTextFrame.maxY, imageFrame.maxY)
        let bottomFrame = CGRect(origin: CGPoint(x: 0, y: bottonTop), size: CGSize(width: screenWidth, height: ConstansSizeCell.bottomViewHeight))
        
        // height cell
        let fullHeight = bottomFrame.maxY
        
        return Size(fullHeight: fullHeight, textFrame: postTextFrame, imageFrame: imageFrame)
    }
    
    func calculateRelation(width: Int, height: Int) -> CGFloat {
        let witdthFloat: Float = Float(width)
        let heightFloat: Float = Float(height)
        return CGFloat(heightFloat / witdthFloat)
        
    }
    
    func calculateTextHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = text.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(size.height)
    }
}

