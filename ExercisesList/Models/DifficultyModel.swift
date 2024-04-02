//
//  DifficultyModel.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import Foundation

protocol DifficultyModellProtocol{
    var difficultyLabel: String { get }
    var difficultyValue: String { get }
}

   
enum DifficultyModel: CaseIterable {
    case beginner, intermediate, expert
}

extension DifficultyModel: DifficultyModellProtocol{
    var difficultyLabel: String {
        switch self{
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .expert:
            return "Expert"
        }
    }
    
    var difficultyValue: String {
        switch self{
        case .beginner:
            return "beginner"
        case .intermediate:
            return "intermediate"
        case .expert:
            return "expert"
        }
    }
}

