//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine

public protocol CacheDataStoreProtocol: AnyObject {
    var remoteConfigUpdateErrorSubject: PassthroughSubject<AppError, Never> { get }
    var appInfoSubject: PassthroughSubject<AppInfo, Never> { get }
    var variantTestSubject: PassthroughSubject<VariantTest, Never> { get }
}
