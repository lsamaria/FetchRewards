//
//  HomeViewModel.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Ivars
    
    let navTitle = "Tap a Dessert"
    
    var datasource: [Meal] = []
    
    let endpointURL: URL
    
    // MARK: - Init
    init(endpointURL: URL) {
        self.endpointURL = endpointURL
    }
}

// MARK: - Fetch Meals
extension HomeViewModel {
    
    func fetchMeals(completion: @escaping ([Meal])->Void) {
        
        Service.shared.fetchData(with: endpointURL) { [weak self] (result) in
            
            switch result {
            
            case .failure(let sessionError):
                
                print("fetch-meals-failed-: ", sessionError)
                
                completion([])
                
            case .success(let data):
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.deserialize(data, completion: completion)
                }
            }
        }
    }
}

// MARK: - Desrialize
extension HomeViewModel {
    
    private func deserialize(_ data: Data, completion: @escaping ([Meal])->Void) {
        
        do {
            
            let mealWrapper = try JSONDecoder().decode(MealWrapper.self, from: data)
            
            guard var meals = mealWrapper.meals else {
                
                print("fetch-meals-are nil")
                completion([])
                return
            }
            
            meals.sort(by: { $0.strMeal ?? "" < $1.strMeal ?? "" })
            
            datasource = meals
            
            completion(datasource)
            
        } catch {
            
            print("fetch-meals-malformed-data-: ", error)
            
            completion([])
        }
    }
}
