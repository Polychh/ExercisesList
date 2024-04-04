//
//  AppCoordinator.swift
//  ExercisesList
//
//  Created by Polina on 04.04.2024.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    private var builder: MainBuilderProtocol
    
    var flowComplitionHandler: CoordinatorHandler?
    
    private var childhoodCoorditors: [CoordinatorProtocol] = .init()
    
    init(navigationController: UINavigationController, builder: MainBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow(){
        let mainFlowCoordinator = MainCoordinator(navigationController: navigationController, builder: builder)
        mainFlowCoordinator.flowComplitionHandler = { [weak self] in
            self?.goToAnotherFlow()
            
        }
        childhoodCoorditors.append(mainFlowCoordinator)
        mainFlowCoordinator.start()
    }
    
    private func goToAnotherFlow(){
        navigationController.setViewControllers([AnotherFlowViewController()], animated: true) // здесь должен быть другой Coordinator но просто для примера пока использую AnotherFlowViewController()
    }
}
