//
//  MealsDetailView.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = DessertViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let mealInfo = viewModel.selectedMealDetail {
                VStack {
                    AsyncImage(url: URL(string: mealInfo.strMealThumb)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .setElevation(.elevation0)

                    Divider()
                        .padding(.top, 15)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(.system(.headline))
                        Text(mealInfo.strInstructions)
                    }
                    .padding()
                    
                    Text("Ingredients:")
                        .font(.system(.headline))
                    ForEach(Array(mealInfo.ingredients.keys.sorted()), id: \.self) { key in
                        Text("\(key): \(mealInfo.ingredients[key]!)")
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchMealDetail(for: mealId)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "An error occurred"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle(viewModel.selectedMealDetail?.strMeal ?? "Meal Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MealDetailView(mealId: "53049")
}
