//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol ClipboardDriverProtocol: AnyObject {
    var copiedValue: String? { get }

    func copy(_ string: String)
}
