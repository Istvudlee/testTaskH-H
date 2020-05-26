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
    var response: NewsLineModel
}

struct NewsLineModel:Decodable {
    var items: [NewsLineItem]
    var groups: [NewsLineGroups]
    var profiles: [NewsLineProfile]
}

struct NewsLineItem: Decodable {
    var sourceId: Int
    var date: Double?
    var text: String?
    var likes: CountPost?
    var reposts: CountPost?
    var views: CountPost?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case text
        case likes
        case reposts
        case views
    }
}

struct NewsLineProfile: Decodable, GroupsAndProfile {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var photo: String?
    
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
    var id: Int?
    var name: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}

struct CountPost: Decodable {
    var count: Int?
}

