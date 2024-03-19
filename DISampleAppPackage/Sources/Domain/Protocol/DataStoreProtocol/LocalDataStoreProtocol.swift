//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol LocalDataStoreProtocol: AnyObject {
    var launchAppCount: Int { get set }
    var isCompletedOnboarding: Bool { get set }
    var apnsToken: Data? { get set }

    func allClear()
}
