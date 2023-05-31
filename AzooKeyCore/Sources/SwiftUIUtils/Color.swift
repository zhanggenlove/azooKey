//
//  Color.swift
//  azooKey
//
//  Created by ensan on 2020/11/28.
//  Copyright © 2020 ensan. All rights reserved.
//

import SwiftUI
#if os(iOS)
import UIKit

public extension Color {
    static let systemGray = Color(UIColor.systemGray)
    static let systemGray2 = Color(UIColor.systemGray2)
    static let systemGray3 = Color(UIColor.systemGray3)
    static let systemGray4 = Color(UIColor.systemGray4)
    static let systemGray5 = Color(UIColor.systemGray5)
    static let systemGray6 = Color(UIColor.systemGray6)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let background = Color(UIColor.systemBackground)
    static let label = Color(UIColor.label)
}
#elseif os(macOS)
import AppKit
public extension Color {
    // TODO: これらの実装はmacOSでテストしておらず、ビルドを通すだけのものになっているので、必要に応じて修正する
    static let systemGray = Color(NSColor.systemGray)
    static let systemGray2 = Color(white: 0.3)
    static let systemGray3 = Color(white: 0.2)
    static let systemGray4 = Color(white: 0.1)
    static let systemGray5 = Color(white: 0.05)
    static let systemGray6 = Color(white: 0.02)
    static let secondarySystemBackground = Color(NSColor.controlBackgroundColor)
    static let background = Color(NSColor.windowBackgroundColor)
    static let label = Color(NSColor.labelColor)
}

#endif
