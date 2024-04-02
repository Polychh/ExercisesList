//
//  ExercisesSectionsModel.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation

protocol TypeExercisesModelProtocol{
    var typeLabel: String { get }
    var typeValue: String { get }
}

   
enum TypeExercisesModel: CaseIterable {
    case cardio, olympic_weightlifting, plyometrics, powerlifting, strength, stretching, strongman
}

extension TypeExercisesModel: TypeExercisesModelProtocol{
    var typeValue: String {
        switch self{
        case .cardio:
            return "cardio"
        case .olympic_weightlifting:
            return "olympic_weightlifting"
        case .plyometrics:
            return "plyometrics"
        case .powerlifting:
            return "powerlifting"
        case .strength:
            return "strength"
        case .stretching:
            return "stretching"
        case .strongman:
            return "strongman"
        }
    }
    
    var typeLabel: String {
        switch self{
        case .cardio:
            return "Cardio"
        case .olympic_weightlifting:
            return "OlympicWeightlifting"
        case .plyometrics:
            return "Plyometrics"
        case .powerlifting:
            return "Powerlifting"
        case .strength:
            return "Strength"
        case .stretching:
            return "Stretching"
        case .strongman:
            return "Strongman"
        }
    }
}
