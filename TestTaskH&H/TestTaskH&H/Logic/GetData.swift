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
    func getData(_ group: String, filters: String, token: String,  completion: @escaping (NewsLineModelResponse) -> Void) {
        let url = "https://api.vk.com/method/newsfeed.get?filters=\(filters)&source_ids=g<\(group)>&access_token=\(token)&v=5.103"
        print(url)
        guard let urlData = URL(string: url) else { return }
        
        let requsetData = Alamofire.request(urlData)
        requsetData.responseJSON { response in
            switch response.result {
            case .success:
                guard let dataUser = response.data else { return }
                 let dataDecode = try! JSONDecoder().decode(NewsLineModelResponse.self, from: dataUser) 
                completion(dataDecode)
            case .failure:
                print(response.result.error.debugDescription)
            }
        }
    }
}
