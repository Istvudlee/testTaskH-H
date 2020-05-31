//
//  NewsLineModel.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation

protocol GroupsAndProfile {
    var id: Int? { get }
    var name: String? { get }
    var photo: String? { get }
}

struct NewsLineModelResponse: Decodable {
    let response: NewsLineModel
}

struct NewsLineModel:Decodable {
    let items: [NewsLineItem]
    let groups: [NewsLineGroups]
    let profiles: [NewsLineProfile]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items
        case groups
        case profiles
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

struct NewsLineProfile: Decodable, GroupsAndProfile {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let photo: String?
    
    var name: String? {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }

}

struct NewsLineGroups: Decodable, GroupsAndProfile {
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
    let video: Video?
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

struct Video: Decodable {
    let id: Int
    let photo_640: String?
}


