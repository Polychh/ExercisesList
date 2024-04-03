//
//  MainPresenter.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation

enum ParamToNetwork{
    case type
    case muscle
    case difficulty
}

protocol MainViewProtocol: AnyObject{
    func reloadCollectionView()
}

protocol MainPresenterProtocol{
    var dataSections: [ListSectionModel] { get }
    var exetcisesType: [TypeExercisesModel] { get }
    var difficultyType: [DifficultyModel] { get }
    var muscleType: [MuscleTypeModel] { get }
    

    var dataExercises: [ResultExercisesModel] { get }
    func updateDictionaryParam(key: String, value: String, param: ParamToNetwork)
    func fetchBySearchWord(searchWord: String)
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var dataSections: [ListSectionModel] = [.exercisesType, .muscleType, .difficulty, .resultExercises]
    var exetcisesType: [TypeExercisesModel] = TypeExercisesModel.allCases
    var difficultyType: [DifficultyModel] = DifficultyModel.allCases
    var muscleType: [MuscleTypeModel] = MuscleTypeModel.allCases
    
    var dataExercises: [ResultExercisesModel] = .init()
    
    private var dictionaryParam: [String : String] = ["type" : "", "muscle" : "", "difficulty" : ""]
    
    private let network: NetworkMangerProtocol
    
    init(view: MainViewProtocol, network: NetworkMangerProtocol ) {
        self.view = view
        self.network = network
    }
    
    func updateDictionaryParam(key: String, value: String, param: ParamToNetwork) {
        print("key \(key)")
        if dictionaryParam.keys.contains(key) {
            dictionaryParam[key] = value

            if areAllValuesNotEmpty() {
                guard let exercisesType = dictionaryParam["type"], let muscleType = dictionaryParam["muscle"], let difficultyType = dictionaryParam["difficulty"] else { return }
                print("AllParam")
                print("dictionaryParam1 \(dictionaryParam)")
                fetchallParam(typeMuscle: muscleType, typeDifficulty: difficultyType, typeExercises: exercisesType)
            } else{
                chooseRequest(param: param, value: value)
            }
            print("dictionaryParam \(dictionaryParam)")
        } else {
            print("Invalid key: \(key)")
        }
    }
    
    private func chooseRequest(param: ParamToNetwork, value: String){
        switch param{
        case .type:
            fetchExercisesType(typeExercises: value)
        case .muscle:
            fetchMuscleType(typeMuscle: value)
        case .difficulty:
            fetchDifficultyType(typeDifficulty: value)
        }
    }

    
    
    private func areAllValuesNotEmpty() -> Bool {
        for (_, value) in dictionaryParam {
            if value.isEmpty {
                return false
            }
        }
        return true
    }
    
    private func clearDictionaryValues() {
        for key in dictionaryParam.keys {
            dictionaryParam[key] = ""
        }
    }
    
    
    
    private  func fetchExercisesType(typeExercises: String){
        let request = ExercisesRequest(name: nil, typeExercises: typeExercises, typeMuscle: nil, difficultyType: nil, paramToChoose: .typeExercises)
        fetchData(request: request)
    }
    
    private func fetchMuscleType(typeMuscle: String){
        let request = ExercisesRequest(name: nil, typeExercises: nil, typeMuscle: typeMuscle, difficultyType: nil, paramToChoose: .typeMuscle)
        fetchData(request: request)
    }
    
    private func fetchDifficultyType(typeDifficulty: String){
        let request = ExercisesRequest(name: nil, typeExercises: nil, typeMuscle: nil, difficultyType: typeDifficulty, paramToChoose: .difficultyType)
        fetchData(request: request)
    }
    
    private func fetchallParam(typeMuscle: String, typeDifficulty: String,  typeExercises: String){
        let request = ExercisesRequest(name: nil, typeExercises: typeExercises, typeMuscle: typeMuscle, difficultyType: typeDifficulty, paramToChoose: .allParam)
        fetchData(request: request)
        //clearDictionaryValues() // clean paramDictionary
    }
    
    func fetchBySearchWord(searchWord: String){
        let request = ExercisesRequest(name: searchWord, typeExercises: nil, typeMuscle: nil, difficultyType: nil, paramToChoose: .name)
        fetchData(request: request)
    }
   
    
    private func fetchData(request: ExercisesRequest ){
        Task{ @MainActor in
            do{
                let data = try await network.request(request)
                dataExercises = data
                view?.reloadCollectionView()
                print("dataExercises \(dataExercises)")
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}
