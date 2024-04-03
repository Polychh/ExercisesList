//
//  ResultExercisesmodel.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import Foundation

struct ResultExercisesModel: Decodable {
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}

typealias ResultsExercisesData = [ResultExercisesModel]
