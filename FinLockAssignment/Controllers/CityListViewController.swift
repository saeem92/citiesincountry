//
//  CityListViewController.swift
//  FinLockAssignment
//
//  Created by saeem on 09/10/23.
//

import UIKit

class CityListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var cities: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        tableView.dataSource = self
        tableView.delegate = self

    }
        
    @IBAction func btnBackPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let CountrySelectionViewController = storyboard.instantiateViewController(withIdentifier: "CountrySelectionViewController") as? CountrySelectionViewController {
            navigationController?.pushViewController(CountrySelectionViewController, animated: true)
            
        }
    }
}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.lblCityNames.text = cities[indexPath.row]
        return cell
    }

}

