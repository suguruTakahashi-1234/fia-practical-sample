//
//  Created by sugurutakahashi on 2024/03/02
//  Copyright sugurutakahashi. All rights reserved.
//

import UIKit

public extension UIDevice {
    var deviceIdentifier: String {
        #if targetEnvironment(simulator)
            // Ref: 【Swift】シミュレータでもデバイスの種類を取得する https://qiita.com/m-inada0408/items/d8d09f5369618bc99b48
            let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "unknown"
            return identifier
        #else
            // Ref: iOS 端末のモデル識別子を取得する https://tommy10344.hatenablog.com/entry/2020/08/15/003737
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else {
                    return identifier
                }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        #endif
    }
}

