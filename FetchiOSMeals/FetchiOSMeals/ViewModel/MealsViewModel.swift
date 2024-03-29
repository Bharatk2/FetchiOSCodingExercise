//
//  MealsViewModel.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import SwiftUI

/// `DessertViewModel` is responsible for managing the state and interactions for dessert-related views within the application. It fetches and stores a list of desserts (`Meal` objects) and the details for a selected meal (`MealInfo`), using the `MealService` for network requests. The view model updates the state based on the results of these requests, including loading states and error messages, and notifies the views for re-rendering as needed.
class DessertViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMealDetail: MealInfo?
    @Published var isLoading = false
    @Published var showAlert = false
    private var mealService = MealService()

    var errorMessage: String? {
        didSet {
            showAlert = errorMessage != nil
        }
    }
    
    func fetchDesserts() {
        isLoading = true
        mealService.fetchDesserts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealList):
                    self?.meals = mealList.meals
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchMealDetail(for id: String) {
        isLoading = true
        mealService.fetchMealDetail(for: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealDetail):
                    self?.selectedMealDetail = mealDetail.meals.first
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
