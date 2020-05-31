//
//  NewsLineCellModel.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 26.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import UIKit

protocol CellSizesProtocol {
    var textFrame: CGRect { get }
    var imageFrame: CGRect { get }
    var fullHeight: CGFloat { get }
}

struct NewsLineCellModel {
    var name: String
    var date: String
    var photo: String
    var text: String
    var likes: Int
    var reposts: Int
    var views: Int
    var photPost: [PhotosPostForCellModel]
    var sizes: CellSizesProtocol
}

struct PhotosPostForCellModel {
    var url: String
    var width: Int
    var height: Int
}

struct CellSizes: CellSizesProtocol {
    var textFrame: CGRect
    var imageFrame: CGRect
    var fullHeight: CGFloat
}
