//
//  NetworkController.swift
//  Wall-ENASAProject
//
//  Created by Isiah Parra on 5/28/22.
//

import Foundation
import UIKit

class NetworkController {
    
    static let baseURLString = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    static let photos = "photos"
    
    static let kSol = "sol"
    static let kSolValue = "1000"
    static let kAPIKey = "api_key"
    static let apiKeyValue = "wU4UrFWYPaeC2KImSjDFGUvb8Yn2SeHaK1qBRQa0"
    static let earthDate = "earth_date"
    
    static func fetchTopLevel(with url: URL, completion: @escaping (Result<TopLevelDictionary,ResultError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let photoDict = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(photoDict))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    //constructin the URL
    static func fetchPhotos(with searchTerm: String, rover: String, completion: @escaping (Result<Photo,ResultError>) -> Void) {
        guard let baseURL = URL(string: baseURLString) else {
            completion(.failure(.noData))
            return
        }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "rover/\(photos)"
        let solQueryitem = URLQueryItem(name: kSol, value: kSolValue)
        let apiKeyQuery = URLQueryItem(name: kAPIKey, value: apiKeyValue)
        urlComponents?.queryItems = [apiKeyQuery,solQueryitem]
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
    }

static func fetchImage(with imageString: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
    guard let imageURL = URL(string: imageString) else {
        completion(.failure(.unableToDecode))
        return
    }
    URLSession.shared.dataTask(with: imageURL) { imageData, _, error in
        if let error = error {
            print(error.localizedDescription)
            completion(.failure(.thrownError(error)))
        }
        guard let data = imageData else {
            completion(.failure(.noData))
            return
        }
        guard let image = UIImage(data: data) else {
            completion(.failure(.unableToDecode))
            return
        }
        completion(.success(image))
    }.resume()
}

//     URLSession.shared.dataTask(with: finalURL) { data, _, error in
//                if let error = error {
//                    print("There was an error in accessing the data.", error.localizedDescription)
//                }
//                if let nasaData = data {
//                    do {
//                        guard let topLevelDictionary = try JSONSerialization.jsonObject(with: nasaData, options: .fragmentsAllowed) as? [String:Any], let nasaArray = topLevelDictionary[kNeos] as? [[String:Any]] else
//                        {
//                            completion(nil)
//                            return
//                        }
//                        var tempArray: [NASA] = []
//                        for photoDict in nasaArray {
//                            guard let idk = NASA(dictionary: photoDict) else {completion(nil); return}
//                            tempArray.append(idk)
//                        }
//                        completion(tempArray)
//                    } catch {
//                        print("Error when decoding the data", error.localizedDescription)
//                        completion(nil)
//                    }
//                }
//            }.resume()
//        }
//
//}// end of class
}
