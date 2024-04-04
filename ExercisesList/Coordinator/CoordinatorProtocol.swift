//
//  CoordinatorProtocol.swift
//  ExercisesList
//
//  Created by Polina on 04.04.2024.
//

import UIKit
typealias CoordinatorHandler = () -> ()

protocol CoordinatorProtocol{
    var navigationController: UINavigationController { get set }
    var flowComplitionHandler: CoordinatorHandler? { get set }
    func start()
}
