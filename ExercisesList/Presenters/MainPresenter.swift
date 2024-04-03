//
//  MainPresenter.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject{
    
}

protocol MainPresenterProtocol{
    var dataSections: [ListSectionModel] { get }
    var exetcisesType: [TypeExercisesModel] { get }
    var difficultyType: [DifficultyModel] { get }
    var muscleType: [MuscleTypeModel] { get }
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var dataSections: [ListSectionModel] = [.exercisesType, .muscleType, .difficulty, .resultExercises]
    var exetcisesType: [TypeExercisesModel] = TypeExercisesModel.allCases
    var difficultyType: [DifficultyModel] = DifficultyModel.allCases
    var muscleType: [MuscleTypeModel] = MuscleTypeModel.allCases
    
    var dataExercises: [ResultExercisesModel] = .init()
    
    private let network: NetworkMangerProtocol
    
    init(view: MainViewProtocol, network: NetworkMangerProtocol ) {
        self.view = view
        self.network = network
        fetchCoctailData()
    }
   
    
    private func fetchCoctailData(){
        let request = ExercisesRequest(name: nil, typeExercises: nil, typeMuscle: "biceps", difficultyType: nil, paramToChoose: .typeMuscle)
        Task{ @MainActor in
            do{
                let data = try await network.request(request)
                dataExercises = data
                print("dataExercises \(dataExercises)")
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}
