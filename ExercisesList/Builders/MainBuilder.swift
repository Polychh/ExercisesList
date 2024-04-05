//
//  MainBuilder.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import UIKit

protocol MainBuilderProtocol{
    func buldMainVC(routerDelegate: CoordinatorMainProtocolDelegate) -> UIViewController
    func buildDetailVC(routerDelegate: CoordinatorMainProtocolDelegate, searchWord: String) -> UIViewController
}

final class MainBuilder: MainBuilderProtocol{
    func buildDetailVC(routerDelegate: CoordinatorMainProtocolDelegate, searchWord: String) -> UIViewController{
        let vc = DetailViewController()
        let networkManager = NetworkManager()
        let presenter = DetailPresenter(view: vc, routerDelegate: routerDelegate, searchWord: searchWord, network: networkManager)
        vc.presenter = presenter
        return vc
    }
    
    func buldMainVC(routerDelegate: CoordinatorMainProtocolDelegate) -> UIViewController {
        let vc = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: vc, network: networkManager, routerDelegate: routerDelegate)
        vc.presenter = presenter
        return vc
    }
    
    
}
