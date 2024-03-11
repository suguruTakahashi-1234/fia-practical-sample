//
//  Created by sugurutakahashi on 2024/03/08
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine

public actor CacheDataStore: CacheDataStoreProtocol {
    public let remoteConfigUpdateErrorSubjecter = PassthroughSubject<AppError, Never>()
    public let appInfoSubjecter = CurrentValueSubject<AppInfo, Never>(AppInfo.defaultValue)
    public let variantTestSubjecter = CurrentValueSubject<VariantTest, Never>(VariantTest.defaultValue)

    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }
}
