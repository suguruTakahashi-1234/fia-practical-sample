//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol DeviceNameDriverProtocol: AnyObject {
    /// for DeviceKit SDK
    /// ex) "iPhone 14 Pro"
    var deviceName: String { get }
}
