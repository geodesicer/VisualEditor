//
//  DragState.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-23.
//

import Foundation
import SwiftUI



enum EDragState: Equatable {
    case inactive
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
}

struct EDragStatePreferenceKey: PreferenceKey {
    static var defaultValue: EDragState? = nil

    static func reduce(value: inout EDragState?, nextValue: () -> EDragState?) {
        value = nextValue() ?? value
    }
}



