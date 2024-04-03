//
//  ExercisesRequest.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import Foundation
struct ExercisesRequest: ExercisesRequestProtocol{
   
    typealias Response = ResultsExercisesData
    
    let name: String?
    let typeExercises: String?
    let typeMuscle: String?
    let difficultyType: String?
    let paramToChoose: Param
    
    
    var param: Param{
        paramToChoose
    }
    
    var url: String {
        let baseUrl = "https://api.api-ninjas.com/v1/exercises"
        return baseUrl
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]?{
        let headers = [
            "X-Api-Key": "6vDVHNdWP51NKUVPLaqnWITrVJkdChcdmitaKFhK",
        ]
        return headers
    }
    
    var queryItems: [String : String]?{
        switch paramToChoose{
        case .name:
            if let name {
                let params = [
                    "name": "\(name)",
                ]
                return params
            }
          
        case .typeExercises:
            if let typeExercises{
                let params = [
                    "type": "\(typeExercises)",
                ]
                return params
            }
        case .typeMuscle:
            if let typeMuscle{
                let params = [
                    "muscle": "\(typeMuscle)",
                ]
                return params
            }
        case .difficultyType:
            if let difficultyType{
                let params = [
                    "difficulty": "\(difficultyType)",
                ]
                return params
            }
        case .allParam:
            if let typeExercises, let typeMuscle, let difficultyType{
                let params = [
                    "type": "\(typeExercises)",
                    "muscle": "\(typeMuscle)",
                    "difficulty": "\(difficultyType)",
                ]
                return params
            }
        }
       return nil
    }
}
