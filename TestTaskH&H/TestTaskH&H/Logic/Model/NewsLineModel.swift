//
//  NewsLineModel.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation

struct NewsLineModelResponse: Decodable {
    var response: NewsLineModel
}

struct NewsLineModel:Decodable {
    var items: [NewsLineItem]
}

struct NewsLineItem: Decodable {
    var date: Int?
    var text: String?
    var likes: CountPost?
    var reposts: CountPost?
    var views: CountPost?
    var attachments: [AttachmentsModel]?
}

struct CountPost: Decodable {
    var count: Int?
}

struct AttachmentsModel: Decodable {
    var photo: PhotoModel?
}

struct PhotoModel: Decodable {
    var sizes: [PhotoSizesModel]?
}

struct PhotoSizesModel: Decodable {
    var type: String?
    var url: URL?
}
