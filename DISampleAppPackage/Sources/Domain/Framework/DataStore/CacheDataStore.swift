//
//  Created by sugurutakahashi on 2024/03/08
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine

public actor CacheDataStore: CacheDataStoreProtocol {
    public let remoteConfigUpdateErrorSubject = PassthroughSubject<AppError, Never>()
    public let appInfoSubject = CurrentValueSubject<AppInfo, Never>(AppInfo.defaultValue)
    public let variantTestSubject = CurrentValueSubject<VariantTest, Never>(VariantTest.defaultValue)

    public init() {
        LogDriver.initLog()
    }
}
