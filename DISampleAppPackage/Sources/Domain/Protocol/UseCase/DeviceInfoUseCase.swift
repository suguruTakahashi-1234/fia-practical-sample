//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// UseCase の mockable の適応は Interactor の実装が途中の場合にその Mock を使って Presenter 側で一時的にコードを書き換えて実装をすすめるためである
/// つまり、Interactor は Presenter の切り出しに過ぎず、Mock の差し替えは Driver によってのみ切り替える
/// @mockable
public protocol DeviceInfoUseCase {
    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String
}
