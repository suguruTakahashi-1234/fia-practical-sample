//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine

/// Subject な変数について xxxSubject と命名すると mockolo のバグでどうやら mock のイニシャライザが生成されないので xxxSubjecter に統一している（本当は xxxSubject と命名したい）
/// @mockable
public protocol CacheDataStoreDriverProtocol: AnyObject {
    var remoteConfigUpdateErrorSubjecter: PassthroughSubject<AppError, Never> { get }
    var appInfoSubjecter: CurrentValueSubject<AppInfo, Never> { get }
    var variantTestSubjecter: CurrentValueSubject<VariantTest, Never> { get }
}
