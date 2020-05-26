//
//  GetData.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import Alamofire

class GetData {
    func getData(_ filters: String, token: String,  completion: @escaping ([NewsLineCellModel]) -> Void) {
        let url = "https://api.vk.com/method/newsfeed.get?filters=\(filters)&access_token=\(token)&v=5.103"
        print(url)
        
        guard let urlData = URL(string: url) else { return }
        
        let requsetData = Alamofire.request(urlData)
        
        requsetData.responseJSON { response in
            
            switch response.result {
            case .success:
                guard let dataUser = response.data else { return }
                
                let dataDecode = try! JSONDecoder().decode(NewsLineModelResponse.self, from: dataUser)
                
                let dataCells = dataDecode.response.items.map { newsLineItem  in
                    self.createGeneralDataForCell(modelItem: newsLineItem, groups: dataDecode.response.groups, profile: dataDecode.response.profiles)
                }
                
                completion(dataCells)
            case .failure:
                print(response.result.error.debugDescription)
            }
        }
    }
    
    func createGeneralDataForCell(modelItem: NewsLineItem, groups: [NewsLineGroups], profile: [NewsLineProfile]) -> NewsLineCellModel{
        
        let profileAndGroups: [GroupsAndProfile] = modelItem.sourceId > 0 ? profile : groups
        let positiveSourceId = modelItem.sourceId > 0 ? modelItem.sourceId : -modelItem.sourceId
        let sigleDataProfileOrGrops = profileAndGroups.first { groupsAndProfile in
            groupsAndProfile.id == positiveSourceId
        }
        
        let cell = NewsLineCellModel(name: sigleDataProfileOrGrops?.name ?? "",
                                     photo: sigleDataProfileOrGrops?.photo ?? "",
                                     text: modelItem.text ?? "",
                                     likes: modelItem.likes?.count ?? 0,
                                     reposts: modelItem.reposts?.count ?? 0,
                                     views: modelItem.views?.count ?? 0)
        
        return cell
    }
}
