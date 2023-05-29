//
//  FramePreferenceKey.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI

/**
 In SwiftUI, a PreferenceKey is a type that you can use to carry extra data up the view tree. This allows child views to communicate or pass data to their parent views. In other words, it's a mechanism for views to propagate internal state information upwards.

 The SwiftUI layout system calculates view sizes and positions in a top-down manner (from parents to children). However, in some cases, you need the opposite: a way for child views to influence the layout of parent views or other ancestors. This is where PreferenceKey comes in.

 To use a PreferenceKey, you need to define a custom struct that conforms to the PreferenceKey protocol. This protocol has two requirements:

 defaultValue: This is the value to be used when no other value is provided.
 reduce(value:nextValue:): This is a function that SwiftUI will use to combine multiple values into one. This can be handy if more than one child view is setting the value.
 */

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

