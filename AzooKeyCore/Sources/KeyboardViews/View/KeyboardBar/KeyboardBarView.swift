//
//  KeyboardBarView.swift
//  azooKey
//
//  Created by ensan on 2020/04/10.
//  Copyright © 2020 ensan. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUIUtils

@MainActor
struct KeyboardBarView<Extension: ApplicationSpecificKeyboardViewExtension>: View {
    @EnvironmentObject private var variableStates: VariableStates
    @Binding private var isResultViewExpanded: Bool
    @Environment(Extension.Theme.self) private var theme
    private var useReflectStyleCursorBar: Bool {
        Extension.SettingProvider.useSliderStyleCursorBar
    }

    init(isResultViewExpanded: Binding<Bool>) {
        self._isResultViewExpanded = isResultViewExpanded
    }

    var body: some View {
        switch variableStates.barState {
        case .cursor:
            if useReflectStyleCursorBar {
                ReflectStyleCursorBar<Extension>()
            } else {
                SliderStyleCursorBar<Extension>()
            }
        case .tab:
            let tabBarData = (try? variableStates.tabManager.config.custardManager.tabbar(identifier: 0)) ?? .default
            TabBarView<Extension>(data: tabBarData)
        case .none:
            switch variableStates.tabManager.tab {
            case let .existential(.special(tab)) where tab == .emoji:
                EmojiTabResultBar<Extension>()
            default:
                ResultBar<Extension>(isResultViewExpanded: $isResultViewExpanded)
            }
        }
    }
}

@MainActor
struct KeyboardBarButton<Extension: ApplicationSpecificKeyboardViewExtension>: View {
    enum LabelType {
        case azooKeyIcon(AzooKeyIcon.Looks = .normal)
        case systemImage(String)
    }
    @Environment(Extension.Theme.self) private var theme
    @EnvironmentObject private var variableStates: VariableStates
    private var action: () -> Void
    private let label: LabelType

    init(label: LabelType, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }

    private var buttonBackgroundColor: Color {
        Design.colors.prominentBackgroundColor(theme)
    }

    private var buttonLabelColor: Color {
        theme.resultTextColor.color
    }

    private var circleSize: CGFloat {
        Design.keyboardBarHeight(interfaceHeight: variableStates.interfaceSize.height, orientation: variableStates.keyboardOrientation) * 0.8
    }

    private var iconSize: CGFloat {
        Design.keyboardBarHeight(interfaceHeight: variableStates.interfaceSize.height, orientation: variableStates.keyboardOrientation) * 0.6
    }

    var body: some View {
        Button(action: self.action) {
            ZStack {
                Circle()
                    .strokeAndFill(fillContent: buttonBackgroundColor, strokeContent: theme.borderColor.color, lineWidth: theme.borderWidth)
                    .frame(width: circleSize, height: circleSize)
                switch label {
                case let .azooKeyIcon(looks):
                    AzooKeyIcon(fixedSize: iconSize, color: .color(buttonLabelColor), looks: looks)
                case let .systemImage(name):
                    Image(systemName: name)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundStyle(buttonLabelColor)
                }
            }
        }
        .padding(.all, 5)
    }
}
