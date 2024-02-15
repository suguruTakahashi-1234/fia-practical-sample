//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct License: Identifiable {
    public let id: String
    public let name: String
    public let text: String

    public init(id: String, name: String, text: String) {
        self.id = id
        self.name = name
        self.text = text
    }
}
