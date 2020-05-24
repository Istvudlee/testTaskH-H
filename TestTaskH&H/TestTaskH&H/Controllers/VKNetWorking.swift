//
//  VKNetWorking.swift
//  TestTask
//
//  Created by Анатолий Оруджев on 23.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import Foundation
import VKSdkFramework

class VKNetworking: NSObject {
    
    static let shared = VKNetworking()
    
    private let appId = "7473474"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    weak var delegate: VKNetworkDelegate?
    
    func wakeUpSession(){
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
            case .authorized:
                print("authorized")
                delegate?.vkNetworkAuthorization()
            case .initialized:
                VKSdk.authorize(scope)
            default:
                delegate?.vkNetworkAuthorizationFailed()
                fatalError("fatal error = \(error!.localizedDescription)")
            }
        }
    }
}

extension VKNetworking: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
           delegate?.vkNetworkAuthorization()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.vkNetworkAuthorizationFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.vkNetworkSchoudSchow(controller: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }

}
