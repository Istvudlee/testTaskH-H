//
//  VKNetworkDelegate.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 24.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import UIKit

protocol VKNetworkDelegate: class {
    func vkNetworkSchoudSchow(controller: UIViewController)
    func vkNetworkAuthorization()
    func vkNetworkAuthorizationFailed()
}
