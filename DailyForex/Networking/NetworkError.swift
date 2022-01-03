//
//  NetworkError.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodeError
    case unknownError
    case invalidURL
}
