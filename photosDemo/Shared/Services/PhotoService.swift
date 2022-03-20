//
//  PhotoService.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import Foundation
import Alamofire

final class PhotoService {
    private let photosURL = "https://jsonplaceholder.typicode.com/photos"

    /// gets the photos from the api endpoint
    /// - Parameter completion: a completion block with the result of the endpoint and or errors
    func getPhotos(_ completion: @escaping RequestCompletion) {
        guard let photosEndpoint = URL(string: photosURL) else { return }
        AF.request(photosEndpoint).response { response in
            guard let data = response.data else { return }
            do {
                let photoResponse = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photoResponse))
            } catch let error {
                completion(.failure(.serverError(message: String(describing: error))))
            }
        }
    }
}
