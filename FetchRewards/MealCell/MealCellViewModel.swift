//
//  MealCellViewModel.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import Foundation

final class MealCellViewModel {
    
    // MARK: - Ivars - Obervers
    var mealName: ObservableObject<String?> = ObservableObject(nil)
    
    // MARK: - Init
    init(strMeal: String?) {
        
        mealName.value = strMeal ?? "Meal Title is Unavailable"
    }
}
