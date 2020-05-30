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
    var arrayCells: [NewsLineCellModel] = []
    
    func getData(_ filters: String, token: String,  completion: @escaping ([NewsLineCellModel]) -> Void) {
        let url = "https://api.vk.com/method/newsfeed.get?filters=\(filters)&access_token=\(token)&v=5.103"
        print(url)
        
        guard let urlData = URL(string: url) else { return }
        
        let requsetData = Alamofire.request(urlData)
        
        requsetData.responseJSON { [weak self] response in
            guard let `self` = self else { return }
            switch response.result {
            case .success:
                guard let dataUser = response.data else { return }
                
                let dataDecode = try! JSONDecoder().decode(NewsLineModelResponse.self, from: dataUser) /// try ?

                dataDecode.response.items.forEach( { newsLineItem  in
                    if newsLineItem.sourceId < 0{
                        self.arrayCells.append(self.createGeneralDataForCell(modelItem: newsLineItem, groups: dataDecode.response.groups))
                    }

                })
                print(dataDecode.response.nextFrom)

                completion(self.arrayCells)
            case .failure:
                print(response.result.error.debugDescription)
            }
        }
    }
    
    
    func createGeneralDataForCell(modelItem: NewsLineItem, groups: [NewsLineGroups]) -> NewsLineCellModel{
        let profileAndGroups = groups
        let sigleDataProfileOrGrops = profileAndGroups.first { groupsAndProfile in
            groupsAndProfile.id == -modelItem.sourceId
        }
        
        let cell = NewsLineCellModel(name: sigleDataProfileOrGrops?.name ?? "",
                                     date: createDate(modelItem),
                                     photo: sigleDataProfileOrGrops?.photo ?? "",
                                     text: modelItem.text ?? "",
                                     likes: modelItem.likes?.count ?? 0,
                                     reposts: modelItem.reposts?.count ?? 0,
                                     views: modelItem.views?.count ?? 0, photPost: getArrayPhoto(modelItem))
        
        return cell
    }
    
    private func createDate(_ modelItem: NewsLineItem) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
        
        let date = Date(timeIntervalSince1970: modelItem.date ?? 0.0)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private func getArrayPhoto(_ modelItem: NewsLineItem) -> [String] {
        let attach = modelItem.attachments ?? []
        let array = attach.map({ attachments in
            attachments.photo?.url ?? ""
        })
        return array
    }
}
