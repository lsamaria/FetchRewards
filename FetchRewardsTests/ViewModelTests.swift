//
//  ViewModelTests.swift
//  FetchRewardsTests
//
//  Created by LanceMacBookPro on 11/17/22.
//

import XCTest
@testable import FetchRewards

class ViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func testHomeViewModelEndpointURL() {
        
        let endpoint = Endpoint(path: APIConstants.endpointFilterPath,
                                queryDict: [APIConstants.dessertQueryKey : APIConstants.dessertQueryValue])
        
        let homeViewModel = HomeViewModel(endpointURL: endpoint.url)
        
        let testString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        XCTAssertEqual(homeViewModel.endpointURL.absoluteString, testString)
    }
    
    func testMealCellViewModelStrMealBinder() {
        
        let strMeal = "Madeira Cake"
        
        let mealCellViewModel = MealCellViewModel(strMeal: strMeal)
        
        mealCellViewModel.mealName.bind { (text) in
            XCTAssertEqual(text, strMeal)
        }
    }
    
    func testMealDetailViewModelEndpointURL() {
        
        let idMeal = "52787"
        
        let endpoint = Endpoint(path: APIConstants.endpointLookupPath,
                                queryDict: [APIConstants.mealDetailQueryKey : idMeal])
        
        let mealDetailViewModel = MealDetailViewModel(endpointURL: endpoint.url,
                                                      mealName: "Hot Chocolate Fudge",
                                                      strMealThumb: "https://www.themealdb.com/images/media/meals/xrysxr1483568462.jpg")
        
        let testString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52787"
        
        XCTAssertEqual(mealDetailViewModel.endpointURL.absoluteString, testString)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
}
