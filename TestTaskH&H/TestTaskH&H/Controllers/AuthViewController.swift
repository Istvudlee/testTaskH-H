//
//  AuthViewController.swift
//  TestTaskH&H
//
//  Created by Анатолий Оруджев on 18.05.2020.
//  Copyright © 2020 Istvud. All rights reserved.
//

import UIKit
import VKSdkFramework

class AuthViewController: UIViewController {
    
    // MARK: - private props
    private lazy var buttonLogin: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(AppColors.white, for: .normal)
        button.setTitleColor(AppColors.gray, for: .highlighted)
        button.backgroundColor = AppColors.lightishBlue
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = AppFonts.medium15
        return button
    }()
    
    private var vkNetwork = VKNetworking.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - private method
    private func configureUI() {
        view.backgroundColor = AppColors.white
        view.addSubview(buttonLogin)
        
        buttonLogin.centerYAnchor ~= view.centerYAnchor
        buttonLogin.leadingAnchor ~= view.leadingAnchor + 30
        buttonLogin.trailingAnchor ~= view.trailingAnchor - 30
        buttonLogin.heightAnchor ~= 52
    }
    

    @objc private func tapButton() {
        vkNetwork.wakeUpSession()
    }
}

