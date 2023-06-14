//
//  VUsingPreferenceKey.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



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
