//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public extension String {
    /// - ex) "dependencyInjector" -> "DependencyInjector"
    var initialUppercased: String {
        guard !isEmpty else {
            return ""
        }
        return prefix(1).uppercased() + dropFirst()
    }

    /// - ex) "thisIsCamelCase" -> "this Is Camel Case"
    var camelCaseToSpaces: String {
        reduce("") { result, character in
            if character.isUppercase, result.isEmpty == false {
                "\(result) \(character)"
            } else {
                result + String(character)
            }
        }
    }

    /// - ex1) "snakeCase" -> "snake_case"
    /// - ex2) "SnakeCase" -> "snake_case"
    /// - ex3) "_SnakeCase" -> "_snake_case"
    /// - ex4) "snakeCaseURL0123" -> "snake_case_u_r_l0123"
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

    /// - ex1) "multiplyCircleFill" -> "multiply.circle.fill"
    /// - ex2) "iphoneGen2Circle" -> "iphone.gen2.circle"
    /// - ex3) "person3" -> "person3"
    var toDotSeparatedLowercase: String {
        reduce("") { result, character in
            if character.isUppercase {
                result + "." + character.lowercased()
            } else {
                result + String(character)
            }
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

    /// ex) "LicenseDetailView_Previews" -> "LicenseDetailView"
    var sliceToViewName: String {
        if let range = range(of: "View") {
            String(self[startIndex..<range.upperBound])
        } else {
            // "View"が見つからない場合は元の文字列をそのまま返す
            self
        }
    }

    /// 文字列数をトリミングする
    /// - Parameters:
    ///   - maxLength: 最大文字列長
    /// - Returns: トリミングされた文字列
    /// - ex1) "1234".trimmed(maxLength: 3) -> "123"
    /// - ex2) "12".trimmed(maxLength: 3) -> "12"
    func trimmed(maxLength: Int) -> String {
        if count <= maxLength {
            return self
        }
        return String(prefix(maxLength))
    }
}

extension String: RandomValueProvider {
    public static var random: String {
        random(count: Int.random(in: 0...256))
    }

    public static func random(count: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<count).map { _ in characters.randomElement()! })
    }

    public static var randomIncludingSpecialCharacters: String {
        randomIncludingSpecialCharacters(count: Int.random(in: 0...256))
    }

    public static func randomIncludingSpecialCharacters(count: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:'\",.<>/?"
        return String((0..<count).compactMap { _ in characters.randomElement() })
    }
}

extension String: SizeValueProvider {
    public static var sizeS: String {
        String(localized: "短い文字列", bundle: .module)
    }

    public static var sizeM: String {
        String(localized: "普通の文字列", bundle: .module)
    }

    public static var sizeL: String {
        String(localized: "長い文字列", bundle: .module)
    }
}

extension String: PlaceholderProvider {
    public static var placeholder: String {
        "abc123あいう漢字カナ"
    }
}
