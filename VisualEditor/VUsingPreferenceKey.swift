//
//  VUsingPreferenceKey.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI


/**
 Here's a simple example of using PreferenceKey to pass the width of a child view to its parent view:
 
 1. We define a custom PreferenceKey (WidthPreferenceKey) that will hold a CGFloat value.
 2. In ChildView, we use a GeometryReader to get the size of the Text view and then set a preference for WidthPreferenceKey to the width of the view.
 3. In VUsingPreferenceKey, we use onPreferenceChange to update childWidth whenever the preference for WidthPreferenceKey changes.
 4. VUsingPreferenceKey displays the width of ChildView, and this will update whenever ChildView's width changes.
 */

struct VUsingPreferenceKey: View {
    @State private var childWidth: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Child View Width: \(childWidth)")
            
            ChildView()
                .padding(20)
                .background(Color.red)
                .onPreferenceChange(WidthPreferenceKey.self) { value in
                    self.childWidth = value
                }
        }
    }
}


struct ChildView: View {
    var body: some View {
        Text("Hello, World!")
            .padding(20)
            .background(GeometryReader { geometry in
                Color.blue.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
            })
    }
}


struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
