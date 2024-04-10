//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable(typealias: xxxAT = xxxMock;)
public protocol AppRootPresenterDependency: CommonPresenterDependency, LocalDataStoreDriverProvider {}
