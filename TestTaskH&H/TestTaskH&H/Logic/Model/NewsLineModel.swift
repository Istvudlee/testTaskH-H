//
//  NewsLineModel.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation

struct NewsLineModelResponse: Decodable {
    let response: NewsLineModel
}

struct NewsLineModel:Decodable {
    let items: [NewsLineItem]
    let groups: [NewsLineGroups]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items
        case groups
        case nextFrom = "next_from"
    }
}

struct NewsLineItem: Decodable {
    let sourceId: Int
    let date: Double?
    let text: String?
    let likes: CountPost?
    let reposts: CountPost?
    let views: CountPost?
    let attachments: [Attachments]?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case text
        case likes
        case reposts
        case views
        case attachments
    }
}

struct NewsLineGroups: Decodable {
    let id: Int?
    let name: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}

struct CountPost: Decodable {
    let count: Int?
}

struct Attachments: Decodable {
    let photo: Photo?
    let video: VideoModel?
}

struct Photo: Decodable {
    let sizes: [PhotoSizes]
    
    var url: String {
        getTypeSizePhotoX().url
    }
    
    var width: Int {
        getTypeSizePhotoX().width
    }
    
    var heigt: Int {
        getTypeSizePhotoX().height
    }
    
    private func getTypeSizePhotoX() -> PhotoSizes {
        if let photoSize = sizes.first(where: { $0.type == "x" }) {
            return photoSize
        } 
        return PhotoSizes(type: "don't type", url: "don't url", width: 0, height: 0)
    }
}

struct PhotoSizes: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct VideoModel: Decodable {
    let id: Int?
    let ownerId: Int?
    let accessKey: String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case accessKey = "access_key"
    }
}

struct VideoResponse: Decodable {
    let response: itemsVideo
}

struct itemsVideo: Decodable {
    let items: [VideoResult]
}

struct VideoResult: Decodable {
    let title: String?
    let player: String?
    let width: Int?
    let height: Int?
}
