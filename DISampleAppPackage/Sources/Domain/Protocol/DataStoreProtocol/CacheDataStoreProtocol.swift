//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine

/// @mockable
public protocol CacheDataStoreProtocol: AnyObject {
    var remoteConfigUpdateErrorSubject: PassthroughSubject<AppError, Never> { get }
    var appInfoSubject: CurrentValueSubject<AppInfo, Never> { get }
    var variantTestSubject: CurrentValueSubject<VariantTest, Never> { get }
}
