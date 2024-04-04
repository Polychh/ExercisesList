//
//  MainCoordinator.swift
//  ExercisesList
//
//  Created by Polina on 04.04.2024.
//

import UIKit

protocol CoordinatorMainProtocolDelegate{
    func makeSearch(searchWord: String)
    func goToAnotherFlowCoordinator()
}

final class MainCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    
    private var builder: MainBuilderProtocol
    
    init(navigationController: UINavigationController, builder: MainBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    var flowComplitionHandler: CoordinatorHandler?
    
    func start() {
        showMainVC()
    }
    
    private func showMainVC(){
        let mainVC = builder.buldMainVC(routerDelegate: self)
        navigationController.pushViewController(mainVC, animated: true)
    }
    
    private func goToDetailVC(searchWord: String){
        let detailVC = builder.buildDetailVC(routerDelegate: self, searchWord: searchWord)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    private func goToAnotherFlow(){
        flowComplitionHandler?()
    }
    
    
}

extension MainCoordinator: CoordinatorMainProtocolDelegate{
    func makeSearch(searchWord: String) {
        goToDetailVC(searchWord: searchWord)
    }
    func goToAnotherFlowCoordinator(){
        goToAnotherFlow()
    }
}


