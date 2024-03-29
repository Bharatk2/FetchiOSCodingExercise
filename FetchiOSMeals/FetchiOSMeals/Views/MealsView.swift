//
//  MealsView.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import SwiftUI

struct DessertsView: View {
    @StateObject private var viewModel = DessertViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .setElevation(.elevation0)
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationBarTitle("Desserts")
            .onAppear {
                viewModel.fetchDesserts()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "An unknown error occurred"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    DessertsView()
}
