//
//  ViewController.swift
//  FinLockAssignment
//
//  Created by saeem on 09/10/23.
//

import UIKit

class CountrySelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var btnNext: UIButton!
    
    var countryPicker = UIPickerView()
    var countries: [Datum] = []
    var selectedCountry: Datum?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
            
        countryPicker.delegate = self
        countryPicker.dataSource = self
            
        countryTextField.layer.cornerRadius = 12
        countryTextField.layer.borderWidth = 1
        countryTextField.layer.borderColor = UIColor.red.cgColor
        countryTextField.inputView = countryPicker
        let mediumFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        countryTextField.attributedPlaceholder = NSAttributedString(string: "Select a country", attributes: [NSAttributedString.Key.font: mediumFont])
        
        btnNext.layer.cornerRadius = btnNext.frame.size.height/2
           
        fetchCountries()
    }
        
    func fetchCountries() {
        NetworkManager.shared.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                DispatchQueue.main.async {
                    self?.countryPicker.reloadAllComponents()
                }
            case .failure(let error):
            print("Error fetching countries: \(error)")
            }
        }
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].country
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
        countryTextField.text = countries[row].country
        countryTextField.resignFirstResponder()
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        guard let selectedCountry = selectedCountry else { return }
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cityListViewController = storyboard.instantiateViewController(withIdentifier: "CityListViewController") as? CityListViewController {
        cityListViewController.cities = selectedCountry.cities
        navigationController?.pushViewController(cityListViewController, animated: true)
       }
    }
    

}
    




