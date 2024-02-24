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

    /// ex) "testAppRootView" -> "AppRootView"
    var testRemoveNamed: String {
        self.replacingOccurrences(of: "test", with: "")
    }
}

extension String: RandomValueProvidable {
    public static var random: String {
        random(count: Int.random(in: 0...256))
    }

    public static func random(count: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""

        for _ in 0..<count {
            let randomValue = Int.random(in: 0..<base.count)
            let index: Index = base.index(base.startIndex, offsetBy: randomValue)
            let character: Character = base[index]
            randomString += String(character)
        }
        return randomString
    }
}

extension String: SizeValueProvidable {
    public static var sizeS: String {
        "short str"
    }
    
    public static var sizeM: String {
        "medium length string, medium length string"
    }
    
    public static var sizeL: String {
        "long length string, long string, long string, long string, long string, long string, long string, long string, long string, long string, long string"
    }
}
