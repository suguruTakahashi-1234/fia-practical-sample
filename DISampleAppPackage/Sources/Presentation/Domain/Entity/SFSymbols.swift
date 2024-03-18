//
//  Created by sugurutakahashi on 2024/03/18
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI

public enum SFSymbols: String {
    /// アルファベット順に整列させておくと管理しやすい
    case gearshapeFill
    case iphoneGen3
    case ladybug
    case licenseplate
    case pencilAndListClipboard
    case rectangleGrid1x2
    case squareAndPencil

    public var name: String {
        // SFSymbols の数字の区切りが一定ではないので数字が含まれるものは定義したほうが混乱を防げます
        switch self {
        case .iphoneGen3:
            "iphone.gen3"
        case .rectangleGrid1x2:
            "rectangle.grid.1x2"
        default:
            rawValue.toDotSeparatedLowercase
        }
    }

    public var image: Image {
        Image(systemName: name)
    }
}

/// for Preview
extension SFSymbols: Identifiable, CaseIterable {
    public var id: String {
        name
    }
}

#Preview {
    List {
        ForEach(SFSymbols.allCases.sorted(by: \.name, order: .ascending)) { sfSymbol in
            Label {
                Text(sfSymbol.name)
            } icon: {
                sfSymbol.image
            }
        }
    }
}
