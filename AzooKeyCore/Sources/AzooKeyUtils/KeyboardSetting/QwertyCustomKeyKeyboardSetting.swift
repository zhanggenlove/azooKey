//
//  QwertyCustomKeyKeyboardSetting.swift
//  QwertyCustomKeyKeyboardSetting
//
//  Created by ensan on 2021/08/11.
//  Copyright © 2021 ensan. All rights reserved.
//

import KeyboardViews
import SwiftUI

public protocol QwertyCustomKeyKeyboardSetting: KeyboardSettingKey where Value == QwertyCustomKeysValue {
}

extension QwertyCustomKeysValue: Savable {
    typealias SaveValue = Data
}

public struct NumberTabCustomKeysSetting: QwertyCustomKeyKeyboardSetting {
    public static let defaultValue: QwertyCustomKeysValue = .defaultValue
    public static let title: LocalizedStringKey = "数字タブのカスタムキー機能"
    public static let explanation: LocalizedStringKey = "数字タブの「、。！？…」部分に好きな記号や文字を割り当てて利用することができます。"
    private static let key = "roman_number_custom_keys"
    @MainActor public static var value: QwertyCustomKeysValue {
        get {
            if let value = SharedStore.userDefaults.value(forKey: key), let keys = QwertyCustomKeysValue.get(value) {
                return keys
            }
            return defaultValue
        }
        set {
            SharedStore.userDefaults.set(newValue.saveValue, forKey: key)
        }
    }
}

public extension KeyboardSettingKey where Self == NumberTabCustomKeysSetting {
    static var numberTabCustomKeys: Self { .init() }
}
