//
//  Elevations.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import SwiftUI

public enum DesignTokenElevationType: String, CaseIterable, Identifiable {
    public var id: Self { self }
    case elevation0
}

public struct DesignTokenElevation {
    let color: Color
    let alpha: Double
    let x: Double
    let y: Double
    let blur: Double
    let spread: Double
    
    public init(color: Color, alpha: Double, x: Double, y: Double, blur: Double, spread: Double) {
        self.color = color
        self.alpha = alpha
        self.x = x
        self.y = y
        self.blur = blur
        self.spread = spread
    }
    
    public static let elevation0 = DesignTokenElevation(color: .black, alpha: 0.2, x: 0, y: 14, blur: 28, spread: 0)
    
    public static let elevationMap: [DesignTokenElevationType: DesignTokenElevation] = [
        .elevation0: elevation0,
    ]
    
    public static func fromType(elevation: DesignTokenElevationType) -> DesignTokenElevation {
        elevationMap[elevation] ?? elevation0
    }
}

public extension View {
    /// This method is going to be used to set the drop shadows in the views according to the elevation.
    /// This is an example of best practices for custom tokens.
    /// - Parameter elevation: Elevations enum to choose the level of drop shadow.
    func setElevation(_ elevationType: DesignTokenElevationType) -> some View {
        let elevation = DesignTokenElevation.fromType(elevation: elevationType)
        return self.shadow(color: elevation.color.opacity(elevation.alpha), radius: elevation.blur, x: elevation.x, y: elevation.y)
    }
}

