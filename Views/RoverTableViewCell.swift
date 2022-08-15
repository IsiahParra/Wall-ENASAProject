//
//  RoverTableViewCell.swift
//  Wall-ENASAProject
//
//  Created by Isiah Parra on 8/14/22.
//

import UIKit

class RoverTableViewCell: UITableViewCell {

    @IBOutlet weak var roverImageView: UIImageView!
    
    
    var roversImage: UIImage?
    override func prepareForReuse() {
        roverImageView.image = nil
    }
    
    func fetchImage(for rover: Photo) {
        guard let imageString = rover.img_src else {
            return
        }
        NetworkController.fetchImage(with: imageString) { result in
            switch result {
            case .success(let roverImage):
                DispatchQueue.main.async {
                    self.roverImageView.image = roverImage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func updateViews(with photo: Photo) {
        fetchImage(for: photo)
//        testingLabel.text = photo.img_src ?? "oops"
    }
}
