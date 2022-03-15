//
//  Enums&Typealias.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import Foundation

typealias RequestCompletion = (Result<Any, DataFetchError>) -> Void

public enum DataFetchError: Error {
    case unauthorized
    case invalidParameters
    case invalidOperation
    case serverError(message: String?)
}
