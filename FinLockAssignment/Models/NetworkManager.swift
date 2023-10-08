//
//  NetworkManager.swift
//  FinLockAssignment
//
//  Created by saeem on 09/10/23.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCountries(completion: @escaping (Result<[Datum], Error>) -> Void) {
        let urlString = "https://countriesnow.space/api/v0.1/countries"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
            
            do {
                let countryResponse = try JSONDecoder().decode(Country.self, from: data)
                completion(.success(countryResponse.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
