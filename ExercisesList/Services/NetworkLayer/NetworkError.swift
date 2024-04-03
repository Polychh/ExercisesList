//
//  NetworkError.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import Foundation

enum NetworkError: Error, LocalizedError{
    case invalidURL
    case invalidResponse
    case invalidData
    case unknow(Error)
    
    var errorDescription: String?{
        switch self{
        case .invalidURL:
            return "Wrong URL"
        case .invalidResponse:
            return  "Wrong Response"
        case .invalidData:
            return "Can not to decode Data"
        case .unknow(let error):
            return error.localizedDescription
        }
    }
}
