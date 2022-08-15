//
//  RoverViewModel.swift
//  Wall-ENASAProject
//
//  Created by Isiah Parra on 8/14/22.
//

import Foundation
protocol RoverViewModelDelegate: AnyObject {
    func photosLoadedSuccessfully()
}

class RoverViewModel {
//    var photo: Photo
    var curiostityPhotos: [Photo] = []
    var oppurtunityPhotos: [Photo] = []
    var spiritPhotos: [Photo] = []
    weak var delegate: RoverViewModelDelegate?
    
//    init(delegate: RoverViewModelDelegate) {
//    self.delegate = delegate
//    }
    
    func fetchCuriosity(with searchDate: String) {
        guard let curiosityURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(searchDate)&api_key=\(NetworkController.apiKeyValue)") else { return }
          NetworkController.fetchTopLevel(with: curiosityURL) { [weak self] result in
              switch result {
              case . success(let topLevelDict):
                  self?.curiostityPhotos = topLevelDict.photos
                  self?.delegate?.photosLoadedSuccessfully()
              case .failure(let error):
                  print(error.errorDescription)
              }
          }
    }
    
    func fetchOppurtunity(with searchDate: String) {
        guard let oppurtunityURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?earth_date=\(searchDate)&api_key=\(NetworkController.apiKeyValue)") else { return }
          NetworkController.fetchTopLevel(with: oppurtunityURL) { [weak self] result in
              switch result {
              case . success(let topLevelDict):
                  self?.oppurtunityPhotos = topLevelDict.photos
                  self?.delegate?.photosLoadedSuccessfully()
              case .failure(let error):
                  print(error.errorDescription)
              }
          }
    }
    
    func fetchSpirit(with searchDate: String) {
        guard let spiritURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?earth_date=\(searchDate)&api_key=\(NetworkController.apiKeyValue)") else { return }
          NetworkController.fetchTopLevel(with: spiritURL) { [weak self] result in
              switch result {
              case . success(let topLevelDict):
                  self?.spiritPhotos = topLevelDict.photos
                  self?.delegate?.photosLoadedSuccessfully()
              case .failure(let error):
                  print(error.errorDescription)
              }
          }
    }
}
