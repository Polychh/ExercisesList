//
//  ListSectionModel.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation

enum ListSectionModel: String{
    case exercisesType = "type"
    case muscleType = "muscle"
    case difficulty = "difficulty"
    case resultExercises = "resultExercises"
    
    var title: String{
        switch self{
        case .exercisesType:
            return "ExercisesType"
        case .muscleType:
            return "MuscleType"
        case .difficulty:
            return "Difficulty"
        case .resultExercises:
            return "Results"
        }
    }
}
