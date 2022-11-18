//
//  MealDetailViewModel.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit.UITextView

final class MealDetailViewModel {
    
    // MARK: - Ivars - Observers
    var mealName: ObservableObject<String?> = ObservableObject(nil)
    var instructionsList: ObservableObject<String?> = ObservableObject(nil)
    var ingredientsList: ObservableObject<[String]?> = ObservableObject(nil)
    var measurementsList: ObservableObject<[String]?> = ObservableObject(nil)
    
    // MARK: - Ivars
    var strMealThumb: String?
    
    let endpointURL: URL
    
    // MARK: - Init
    init(endpointURL: URL, mealName: String?, strMealThumb: String?) {
        
        self.endpointURL = endpointURL
        
        self.mealName.value = mealName
        
        self.strMealThumb = strMealThumb
    }
}

// MARK: - Fetch Meal Data
extension MealDetailViewModel {
    
    func fetchMeal(completion: @escaping ()->Void) {
        
        Service.shared.fetchData(with: endpointURL) { (result) in
            switch result {
            
            case .failure(let sessionError):
                
                print("fetch-meal-info-failed-: ", sessionError.localizedDescription)
                
                completion()
            
            case .success(let data):
                
                DispatchQueue.main.async { [weak self] in
                    self?.deserialize(data, completion: completion)
                }
            }
        }
    }
}

// MARK: - Deserialize
extension MealDetailViewModel {
    
    private func deserialize(_ data: Data, completion: @escaping ()->Void) {
        
        do {
            
            let mealWrapper = try JSONDecoder().decode(MealWrapper.self, from: data)
            
            guard let meals = mealWrapper.meals, let meal = meals.first else {
                completion()
                return
            }
            
            setObservers(for: meal)
            
            completion()
            
        } catch {
            
            print("fetch-meal-info-malformed-data-: ", error)
            
            completion()
        }
    }
}

// MARK: - Set Observers
extension MealDetailViewModel {
    
    private func setObservers(for meal: Meal) {
        
        instructionsList.value = "Instructions: \(meal.strInstructions ?? "are unavailable")"
        
        set(ingredientsList, with: "strIngredient", for: meal)
        
        set(measurementsList, with: "strMeasure", for: meal)
    }
    
    private func set(_ list: ObservableObject<[String]?>, with stringPrefix: String, for meal: Meal) {
        
        var propertyValueList = [String]()
        
        let mirror = Mirror(reflecting: meal)
        let properties = mirror.children
        for property in properties {
            
            if let label = property.label, label.contains(stringPrefix), let propertyValue = property.value as? String {
                
                if propertyValue.trimmingCharacters(in: CharacterSet.whitespaces) == "" { continue }
                
                propertyValueList.append(propertyValue)
            }
        }
        
        list.value = propertyValueList
    }
}

// MARK: - Set TextView Text
extension MealDetailViewModel {
    
    func setText(for textView: UITextView, title: String, from list: [String]?) {
        guard let list = list else { return }
        
        if list.isEmpty {
            textView.text = "\(title): are unavailable"
            return
        }
        
        let commaSeparatedString = createCommaSeparatedString(from: list)
        
        textView.text = "\(title): \(commaSeparatedString)"
    }
    
    private func createCommaSeparatedString(from list: [String])->String {
        var outputString: String = ""
        outputString.append(list.map{ "\($0)" }.joined(separator: ", "))
        return outputString
    }
}
