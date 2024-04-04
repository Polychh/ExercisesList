//
//  MainPresenter.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject{
    func reloadCollectionView()
    func showAlert()
    func startActivityIndicator()
    func stopActivityIndicator()
}

protocol MainPresenterProtocol{
    var dataSections: [ListSectionModel] { get }
    var exetcisesType: [TypeExercisesModel] { get }
    var difficultyType: [DifficultyModel] { get }
    var muscleType: [MuscleTypeModel] { get }
    

    var dataExercises: [ResultExercisesModel] { get }
    func updateDictionaryParam(key: String, value: String)
    func fetchBySearchWord(searchWord: String)
    
    var selectedExercisesType: IndexPath { get set }
    var selectedMuscleType: IndexPath { get set }
    var selectedDifficultyType: IndexPath { get set }
    
    func goToDetailVC(searchWord: String)
}

final class MainPresenter: MainPresenterProtocol {
    var selectedDifficultyType: IndexPath = .init()
    var selectedMuscleType: IndexPath = .init()
    var selectedExercisesType: IndexPath = .init()
    
    weak var view: MainViewProtocol?
    private let routerDelegate: CoordinatorMainProtocolDelegate
    
    var dataSections: [ListSectionModel] = [.exercisesType, .muscleType, .difficulty, .resultExercises]
    var exetcisesType: [TypeExercisesModel] = TypeExercisesModel.allCases
    var difficultyType: [DifficultyModel] = DifficultyModel.allCases
    var muscleType: [MuscleTypeModel] = MuscleTypeModel.allCases
    
    var dataExercises: [ResultExercisesModel] = .init()
    
    private var dictionaryParam: [String : String] = ["type" : "", "muscle" : "", "difficulty" : ""]
    
    private let network: NetworkMangerProtocol
    
    init(view: MainViewProtocol, network: NetworkMangerProtocol, routerDelegate: CoordinatorMainProtocolDelegate) {
        self.view = view
        self.network = network
        self.routerDelegate = routerDelegate
    }
    
    func updateDictionaryParam(key: String, value: String) {
        if dictionaryParam.keys.contains(key) {
            dictionaryParam[key] = value

            if areAllValuesNotEmpty() {
                guard let exercisesType = dictionaryParam["type"], 
                      let muscleType = dictionaryParam["muscle"],
                      let difficultyType = dictionaryParam["difficulty"]
                else { return }
                
                fetchallParam(typeMuscle: muscleType, typeDifficulty: difficultyType, typeExercises: exercisesType)
            }
            print("dictionaryParam \(dictionaryParam)")
        } else {
            print("Invalid key: \(key)")
        }
    }
    
    func fetchBySearchWord(searchWord: String){
        let request = ExercisesRequest(name: searchWord, typeExercises: nil, typeMuscle: nil, difficultyType: nil, paramToChoose: .name)
        fetchData(request: request)
    }
    
    func goToDetailVC(searchWord: String){
        routerDelegate.makeSearch(searchWord: searchWord)
    }
        
    
    private func areAllValuesNotEmpty() -> Bool {
        for (_, value) in dictionaryParam {
            if value.isEmpty {
                return false
            }
        }
        return true
    }
    
    
    private func fetchallParam(typeMuscle: String, typeDifficulty: String,  typeExercises: String){
        let request = ExercisesRequest(name: nil, typeExercises: typeExercises, typeMuscle: typeMuscle, difficultyType: typeDifficulty, paramToChoose: .allParam)
        fetchData(request: request)
    }
    
    private func fetchData(request: ExercisesRequest ){
        view?.startActivityIndicator()
        Task{ @MainActor in
            do{
                let data = try await network.request(request)
                dataExercises = data
                view?.reloadCollectionView()
                view?.stopActivityIndicator()
                showAlert(data: dataExercises)
                print("dataExercises \(dataExercises)")
            } catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func showAlert(data: [ResultExercisesModel]){
        if data.isEmpty{
            view?.showAlert()
        }
    }
}
