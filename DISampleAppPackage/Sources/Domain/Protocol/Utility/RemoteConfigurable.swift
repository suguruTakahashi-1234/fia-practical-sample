//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol RemoteConfigurable: Codable {
    static var defaultValue: Self { get }
}
