//
//  DetailPresenter.swift
//  ExercisesList
//
//  Created by Polina on 04.04.2024.
//

import Foundation

protocol DetailViewProtocol: AnyObject{
    
}

protocol DetailPresenterProtocol{
    func goToAnotherFlow()
}

final class DetailPresenter: DetailPresenterProtocol{
   
    
    weak var view: DetailViewProtocol?
    private let routerDelegate: CoordinatorMainProtocolDelegate
    private let searchWord: String
    
    init(view: DetailViewProtocol, routerDelegate: CoordinatorMainProtocolDelegate, searchWord: String) {
        self.view = view
        self.routerDelegate = routerDelegate
        self.searchWord = searchWord
    }
    
    func goToAnotherFlow() {
        routerDelegate.goToAnotherFlowCoordinator()
    }
}
