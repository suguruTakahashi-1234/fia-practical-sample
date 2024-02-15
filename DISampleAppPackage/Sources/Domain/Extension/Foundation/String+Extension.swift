//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public extension String {    
    /// ex1) "snakeCase" -> "snake_case"
    /// ex2) "SnakeCase" -> "snake_case"
    /// ex3) "_SnakeCase" -> "_snake_case"
    /// ex4) "snakeCaseURL0123" -> "snake_case_u_r_l0123"
    var toSnakeCase: String {
        let snakeCased = unicodeScalars.reduce("") { result, scalar in
            if CharacterSet.uppercaseLetters.contains(scalar) {
                "\(result)_\(Character(scalar))"
            } else {
                result + String(scalar)
            }
        }.lowercased()
        
        if snakeCased.hasPrefix("_") {
            return String(snakeCased.dropFirst())
        } else {
            return snakeCased
        }
    }
    
    /// ex) "/Presentation/License/LicenseDetailPresenter.swift" -> "LicenseDetailPresenter".swift"
    var lastPathComponent: String {
        split(separator: "/").last?.description ?? ""
    }
    
    /// ex) "/Presentation/License/LicenseDetailPresenter.swift" -> "LicenseDetailPresenter"
    var fileNameWithoutExtension: String {
        let lastPathComponent = split(separator: "/").last?.description ?? ""
        let components = lastPathComponent.split(separator: ".")
        return components.dropLast().joined(separator: ".")
    }
}
