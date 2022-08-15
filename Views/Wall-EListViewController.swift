//
//  Wall-EListViewController.swift
//  Wall-ENASAProject
//
//  Created by Isiah Parra on 5/28/22.
//

import UIKit

class Wall_EListViewController: UIViewController {
    
    
    let viewModel = RoverViewModel()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nasaSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nasaSearchBar.delegate = self
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.titleForSegment(at: 0)
//            viewModel.fetchCuriosity(with: nasaSearchBar.text!)
        case 1:
            segmentedControl.titleForSegment(at: 1)
//            viewModel.fetchSpirit(with: nasaSearchBar.text!)
        case 2:
            segmentedControl.titleForSegment(at: 2)
//            viewModel.fetchOppurtunity(with: nasaSearchBar.text!)
        default:
            break
        }
        tableView.reloadData()
    }
    
    
}// End of class
extension Wall_EListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.curiostityPhotos.count
        case 1:
            return viewModel.oppurtunityPhotos.count
        default:
            return viewModel.spiritPhotos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nasaCell", for: indexPath) as?
                RoverTableViewCell else { return UITableViewCell()}
        let photo: Photo
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            photo = viewModel.curiostityPhotos[indexPath.row]
        case 1:
            photo = viewModel.oppurtunityPhotos[indexPath.row]
        default:
            photo = viewModel.spiritPhotos[indexPath.row]
        }
        cell.updateViews(with: photo)
        return cell
    }
    
    
}

extension Wall_EListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.fetchCuriosity(with: searchText)
        viewModel.fetchSpirit(with: searchText)
        viewModel.fetchOppurtunity(with: searchText)
    }
}
extension Wall_EListViewController: RoverViewModelDelegate {
    func photosLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
