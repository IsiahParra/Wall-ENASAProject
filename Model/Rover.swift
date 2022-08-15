//
//  Rover.swift
//  Wall-ENASAProject
//
//  Created by Isiah Parra on 8/14/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let photos: [Photo]
}

struct Photo: Decodable {
    let id: Int
    let sol: Int
    let camera: Camera
    let earth_date: String
    let rover: Rover
    let img_src: String?
}

struct Camera: Decodable {
    let id: Int
    let name: String
}

struct Rover: Decodable {
    let id: Int
    let name: String
}
