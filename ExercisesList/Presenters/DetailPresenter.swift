//
//  DetailPresenter.swift
//  ExercisesList
//
//  Created by Polina on 04.04.2024.
//

import Foundation

protocol DetailViewProtocol: AnyObject{
    func reloadData()
}

protocol DetailPresenterProtocol{
    func goToAnotherFlow()
    func fetchBySearchWord(searchWord: String)
    var dataSerachWord: [ResultExercisesModel] { get }
}

final class DetailPresenter: DetailPresenterProtocol{
    var dataSerachWord: [ResultExercisesModel] = .init()

    weak var view: DetailViewProtocol?
    private let routerDelegate: CoordinatorMainProtocolDelegate
    private let searchWord: String
    private let network: NetworkMangerProtocol
    
    init(view: DetailViewProtocol, routerDelegate: CoordinatorMainProtocolDelegate, searchWord: String, network: NetworkMangerProtocol) {
        self.view = view
        self.routerDelegate = routerDelegate
        self.network = network
        self.searchWord = searchWord
        fetchBySearchWord(searchWord: searchWord)
    }
    
    func fetchBySearchWord(searchWord: String){
        let request = ExercisesRequest(name: searchWord, typeExercises: nil, typeMuscle: nil, difficultyType: nil, paramToChoose: .name)
        fetchData(request: request)
    }
    
    func goToAnotherFlow() {
        routerDelegate.goToAnotherFlowCoordinator()
    }
    
    private func fetchData(request: ExercisesRequest ){
        //view?.startActivityIndicator()
        Task{ @MainActor in
            do{
                let data = try await network.request(request)
                dataSerachWord = data
                view?.reloadData()
                //view?.stopActivityIndicator()
                //showAlert(data: dataExercises)
                print("dataSerachWord \(dataSerachWord)")
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}
