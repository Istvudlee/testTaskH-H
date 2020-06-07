//
//  GetData.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import Alamofire
enum ChoiceGetData {
    case data
    case dataNext
}
class GetData {
    var arrayCells: [NewsLineCellModel] = []
    var calculate: CalculateCellSize = CalculateCellSize()
    var onSuccessGetData: (([NewsLineCellModel]) -> Void)?
    var response : NewsLineModel?
    
    func getData(token: String, state: ChoiceGetData = .data) {
        var params = ["filters": "post"]
        params["v"] = APIVk.version
        params["access_token"] = token

        if state == .dataNext {
            params["start_from"] = self.response?.nextFrom
        }
        
        let urlData = createURl(params: params)
        let requsetData = Alamofire.request(urlData)
        
        requsetData.responseJSON { [weak self] response in
            guard let `self` = self else { return }
            switch response.result {
            case .success:
                guard let dataUser = response.data else { return }
                
                guard let dataDecode = try? JSONDecoder().decode(NewsLineModelResponse.self, from: dataUser) else { return }
                
                guard self.response?.nextFrom != dataDecode.response.nextFrom else { return }
                self.response = dataDecode.response
                
                dataDecode.response.items.forEach( { newsLineItem  in
                    if newsLineItem.sourceId == -29302425{
                        self.arrayCells.append(self.createGeneralDataForCell(modelItem: newsLineItem, groups: dataDecode.response.groups))
                    }
                    
                })
                
                self.onSuccessGetData?(self.arrayCells)
                
            case .failure:
                print(response.result.error.debugDescription)
            }
        }
    }
    
    
    func createGeneralDataForCell(modelItem: NewsLineItem, groups: [NewsLineGroups]) -> NewsLineCellModel{
        let arrGroups = groups
        let singleDataGrops = arrGroups.first { groupsAndProfile in
            groupsAndProfile.id == -modelItem.sourceId
        }
        let firstphoto = getPhoto(modelItem)
        let sizes = calculate.getSize(modelItem.text, images: firstphoto)
        let cell = NewsLineCellModel(name: singleDataGrops?.name ?? "",
                                     date: createDate(modelItem),
                                     photo: singleDataGrops?.photo ?? "",
                                     text: modelItem.text ?? "",
                                     likes: modelItem.likes?.count ?? 0,
                                     reposts: modelItem.reposts?.count ?? 0,
                                     views: modelItem.views?.count ?? 0, photPost: firstphoto,
                                     sizes: sizes)
        
        return cell
    }
    
    // MARK: - private method
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
    
    private func getPhoto(_ modelItem: NewsLineItem) -> [PhotosPostForCellModel] {
        guard let attachments = modelItem.attachments else { return [] }
        
        return attachments.compactMap { attachment in
            guard let photoPost = attachment.photo else { return nil }
            return PhotosPostForCellModel(url: photoPost.url, width: photoPost.width, height: photoPost.heigt)
        }
        
        //        print(firstPhoto.width , firstPhoto.heigt)
        
    }
    
    private func createURl(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = APIVk.scheme
        components.host = APIVk.host
        components.path = APIVk.method
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}

