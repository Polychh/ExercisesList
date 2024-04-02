//
//  MuscleTypeModel.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation
protocol MuscleTypeModelProtocol{
    var muscleLabel: String { get }
    var muscleValue: String { get }
}

   
enum MuscleTypeModel: CaseIterable {
    case abdominals, abductors, adductors, biceps, calves, chest, forearms, glutes, hamstrings, lats, lower_back, middle_back, neck, quadriceps, traps, triceps
}

extension MuscleTypeModel: MuscleTypeModelProtocol{
    var muscleLabel: String {
        switch self{
        case .abdominals:
            return "Abdominals"
        case .abductors:
            return "Abductors"
        case .adductors:
            return "Adductors"
        case .biceps:
            return "Biceps"
        case .calves:
            return "Calves"
        case .chest:
            return "Chest"
        case .forearms:
            return "Forearms"
        case .glutes:
            return "Glutes"
        case .hamstrings:
            return "Hamstrings"
        case .lats:
            return "Lats"
        case .lower_back:
            return "LowerBack"
        case .middle_back:
            return "MiddleBack"
        case .neck:
            return "Neck"
        case .quadriceps:
            return "Quadriceps"
        case .traps:
            return "Traps"
        case .triceps:
            return "Triceps"
        }
    }
    
    var muscleValue: String {
        switch self{
        case .abdominals:
            return "abdominals"
        case .abductors:
            return "abductors"
        case .adductors:
            return "adductors"
        case .biceps:
            return "biceps"
        case .calves:
            return "calves"
        case .chest:
            return "chest"
        case .forearms:
            return "forearms"
        case .glutes:
            return "glutes"
        case .hamstrings:
            return "hamstrings"
        case .lats:
            return "lats"
        case .lower_back:
            return "lower_back"
        case .middle_back:
            return "middle_back"
        case .neck:
            return "neck"
        case .quadriceps:
            return "quadriceps"
        case .traps:
            return "traps"
        case .triceps:
            return "triceps"
        }
    }
    
    
}
