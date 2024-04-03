//
//  MainBuilder.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import UIKit

protocol MainBuilderProtocol{
    func buldMainVC() -> UIViewController
}

final class MainBuilder: MainBuilderProtocol{
    func buldMainVC() -> UIViewController {
        let vc = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: vc, network: networkManager)
        vc.presenter = presenter
        return vc
    }
    
    
}
